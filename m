Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJGPTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJGPTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUJGPSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:18:31 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:31924 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267334AbUJGPOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:14:52 -0400
Message-ID: <001801c4ac88$c9da6780$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <root@chaos.analogic.com>
Cc: <linux@horizon.com>, <aeb@cwi.nl>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20041007135110.16475.qmail@science.horizon.com> <Pine.LNX.4.61.0410071005010.3331@chaos.analogic.com> <1097156530.31754.40.camel@localhost.localdomain>
Subject: Re: [PATCH] poll(2) man page, likewise.
Date: Thu, 7 Oct 2004 17:14:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> On Iau, 2004-10-07 at 15:26, Richard B. Johnson wrote:
> > Wrong. It is a Linux kernel mistake to fail to implement a common
> > system call properly.
> 
> Actually if you dig deeply only pselect() has posix guarantees, and we
> don't implement that.

pselect() and select() are both in POSIX and should behave the same
except for different arguments..


--ms


