Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272392AbTHIPBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272393AbTHIPBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:01:13 -0400
Received: from fepz.post.tele.dk ([195.41.46.133]:51881 "EHLO
	fepZ.post.tele.dk") by vger.kernel.org with ESMTP id S272392AbTHIPBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:01:11 -0400
Message-ID: <002e01c35e87$14c1ffc0$ee52a450@theoden>
From: =?iso-8859-1?Q?Henrik_R=E6der_Clausen?= <henrik@fangorn.dk>
To: "gaxt" <gaxt@rogers.com>,
       "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: <preining@logic.at>, <linux-kernel@vger.kernel.org>
References: <3F34D0EA.8040006@rogers.com><Pine.LNX.4.56.0308091030590.16795@filesrv1.baby-dragons.com> <3F3509C0.9050403@rogers.com>
Subject: Re: 2.6.0-test3 cannot mount root fs
Date: Sat, 9 Aug 2003 17:01:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "gaxt" <gaxt@rogers.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>

> It's not a lilo issue (ie. I use grub) I ran into the issue when I first
> started with the 2.6.0 series test kernels.

   I had it occasionally in the 2.5.X series, as well as with 2.6.0-test2.
To me it seems like some apparently unrelated config setting causes this.
I'd go over the config again, change a few settings that seem to make
sense - but nothing obvious - then recompile and get a healthy kernel.

   I'm using Grub and ext3, for the record.


    -Henrik

