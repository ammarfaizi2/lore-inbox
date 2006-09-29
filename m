Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWI2BeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWI2BeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 21:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWI2BeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 21:34:22 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:15748 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161264AbWI2BeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 21:34:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=Q/gNEGr7/61AtwhWjqvTqpWh1PmzLIwqjwvNNvpjeA7a0CnjhZuieFYqE6RycQe1;
  h=Received:Message-ID:From:To:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MIMEOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <024101c6e367$5f471b30$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca> <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
Subject: Re: GPLv3 Position Statement
Date: Thu, 28 Sep 2006 18:34:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112094f50f6ac91a8622a80f266751070f0e0ca2637590cc961d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.187.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Linus Torvalds" <torvalds@osdl.org>

> Exactly. The GPLv3 can _only_ take over a GPLv2 project if the "or later" 
> exists.
> 
> It should also be pointed out that even a "GPLv2 or later" project can be 
> forked two different ways: you can turn it into a "GPLv3" (with perhaps a 
> "or later" added too) project, but you can _equally_ turn it into a "GPLv2 
> only" project.
> 
> In other words, even if the license says "GPLv2 or later", the GPLv3 isn't 
> actually "stronger". The original author dual-licensed it, and expressly 
> told you that he's ok with any GPL version greater than or equal to 2.

And if it is dual licensed and the user gets to pick the license what
does it mean to have GPLv3 as part of an OR clause? Those who would use
or reuse the code can ignore the GPLv3 part and go forward as GPLv2.
The intent of "GPLv2 or later" might have been "latest GPL version".
But that is not what the words rather explicitly declare.

{^_-}    Joanne
