Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbSLSXI7>; Thu, 19 Dec 2002 18:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbSLSXI6>; Thu, 19 Dec 2002 18:08:58 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:30478 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267644AbSLSXI5>; Thu, 19 Dec 2002 18:08:57 -0500
To: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: /proc/mounts and data=journal
References: <200212192316.51412.bofh@coker.com.au>
In-Reply-To: <200212192316.51412.bofh@coker.com.au> (Russell Coker's message
 of "Thu, 19 Dec 2002 23:16:51 +0100")
From: Matthias Andree <ma+rfs@dt.e-technik.uni-dortmund.de>
Date: Fri, 20 Dec 2002 00:16:47 +0100
Message-ID: <m3fzst8uqo.fsf@merlin.emma.line.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i586-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker <bofh@coker.com.au> writes:

> I've applied the patches for mounting with data=journal.  However one problem 
> that I have discovered is that the data=journal status of a file system is 
> not shown in /proc/mounts, other tunable options of a file system such as 
> noatime are shown.

This also affects ext3fs. Leaving full quote and posting to linux-kernel
as well.

-- 
Matthias Andree
