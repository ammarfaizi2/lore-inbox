Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbUKMX7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbUKMX7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKMX7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:59:16 -0500
Received: from main.gmane.org ([80.91.229.2]:40153 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261213AbUKMX7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:59:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: System call number
Date: Sun, 14 Nov 2004 00:59:04 +0100
Message-ID: <yw1x6549jo6v.fsf@ford.inprovide.com>
References: <41969845.1060803@euroweb.net.mt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:IGCPJvsxWannOZhO0nU80aFnH88=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Josef E. Galea" <josefeg@euroweb.net.mt> writes:

> Hi,
>
> Can anyone tell me the system call number for the function
> write_swap_page() (in kernel/power/pmdisk.c) as I can't find it in
> unistd.h.

What makes you believe that function is a system call in the first
place?  It doesn't look like one to me.  Hint: system calls have names
prefixed with sys_ (are there any exceptions?).

-- 
Måns Rullgård
mru@inprovide.com

