Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVEJKDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVEJKDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVEJKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:03:51 -0400
Received: from lan-202-144-86-147.maa.sify.net ([202.144.86.147]:12932 "EHLO
	ringuva.blr.novell.com") by vger.kernel.org with ESMTP
	id S261603AbVEJKDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:03:45 -0400
Subject: Re: Crashing red hat linux
From: Raj Inguva <inguva@gmail.com>
To: dipankar das <dipankar_dd@yahoo.com>
Cc: akt-announce@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
References: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 May 2005 15:33:41 +0530
Message-Id: <1115719421.1436.1.camel@ringuva.blr.novell.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Does Red hat like Monta vista allow crashing the
> kernel by writing to  "/dev/crash" if not whats the
> easiest way ?
> 

I used to insmod a driver which calls panic() during module
initialization. I used to do this for testing lkcd.

Raj
