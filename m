Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVBJWOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVBJWOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 17:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBJWOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 17:14:31 -0500
Received: from web26502.mail.ukl.yahoo.com ([217.146.176.39]:2949 "HELO
	web26502.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261874AbVBJWOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 17:14:23 -0500
Message-ID: <20050210221419.53574.qmail@web26502.mail.ukl.yahoo.com>
Date: Thu, 10 Feb 2005 22:14:19 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: NFS (ext3/VFS?) bug in 2.6.8/10
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Neil Conway <nconway_kernel@yahoo.co.uk> wrote:
> works even on machines with 256MB of RAM.  The odd thing I haven't
> figured out yet is that the fuslwr machine mentioned above has 2GB of
> RAM, and ALL of it is HIGHMEM.  Must be a kernel CONFIG option I
> guess.
>  (Rant: what replaces Configure.help???)

D'oh!!  Brain fade.  I mean to type, "2GB of RAM, and ALL of it is
LOWMEM".  Sigh...

Neil


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search.
http://info.mail.yahoo.com/mail_250
