Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRHAIh2>; Wed, 1 Aug 2001 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbRHAIhS>; Wed, 1 Aug 2001 04:37:18 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36813 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S264797AbRHAIhC>; Wed, 1 Aug 2001 04:37:02 -0400
Date: Wed, 1 Aug 2001 10:39:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Rick Hohensee <humbubba@smarty.smart.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: LANCE ethernet chip - ~24 drivers
In-Reply-To: <200107311658.MAA03706@smarty.smart.net>
Message-ID: <Pine.GSO.3.96.1010801102933.19537B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Rick Hohensee wrote:

> One has to wonder. I was looking at 1.2.13 and there is mention of
> splitting a driver, I forget which one, because there are two bits with
> reversed sense in later versions of a card. 

 Hmm, forking a driver due to a two-bit difference is a nonsense IMHO. 
Now you have two separate drivers with code updates happening in one of
them only each time. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

