Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUBAXnd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbUBAXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:43:33 -0500
Received: from s4.uklinux.net ([80.84.72.14]:37844 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S265573AbUBAXnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:43:32 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>
	<20040201151111.4a6b64c3.akpm@osdl.org>
From: Philip Martin <philip@codematters.co.uk>
Date: Sun, 01 Feb 2004 23:42:55 +0000
In-Reply-To: <20040201151111.4a6b64c3.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 1 Feb 2004 15:11:11 -0800")
Message-ID: <87k736e58g.fsf@codematters.co.uk>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Philip Martin <philip@codematters.co.uk> wrote:
>>
>>  My test is a software build of about 200 source files (written in C)
>>  that I usually build using "nice make -j4".
>
> Tried -j3?

I've tried -j2 and -j3, the results are much the same as -j4.

-- 
Philip Martin
