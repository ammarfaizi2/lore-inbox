Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263158AbVCEQgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbVCEQgs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCEQca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:32:30 -0500
Received: from tim.rpsys.net ([194.106.48.114]:64993 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262213AbVCEQZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:25:15 -0500
Message-ID: <01b801c5219f$df6a00b0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "LKML" <linux-kernel@vger.kernel.org>, "Ian Molton" <spyro@f2s.com>
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <4229B847.5050301@drzeus.cx>
Subject: Re: [PATCH][MMC] Secure Digital (SD) support
Date: Sat, 5 Mar 2005 16:24:47 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman:
> First of, I can't really back up the claim that it isn't ok. The SDA has a 
> paragraph about non-disclosure in their "IP Policy" 
> (http://www.sdcard.org/membership/images/ippolicy.pdf) but it also states 
> that exceptions can be granted.

That IP policy covers their members and has no bearing on us as we have no 
agreements with them.

The code is "our" own so it isn't covered by any IP or copyright 
restrictions other than the GPL.

There aren't any patents relating to SD cards.

The simple sequences we use have been gleaned from various public documents 
(intel's website, SD card manufacturer data sheets, etc.) so nobody can 
claim we're using anything secret.

I therefore can't see a problem with including the code.

Richard 

