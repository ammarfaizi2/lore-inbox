Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136897AbRATAV0>; Fri, 19 Jan 2001 19:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136934AbRATAVQ>; Fri, 19 Jan 2001 19:21:16 -0500
Received: from mout1.freenet.de ([194.97.50.132]:58306 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S136897AbRATAVP>;
	Fri, 19 Jan 2001 19:21:15 -0500
From: mkloppstech@freenet.de
Message-Id: <200101200020.BAA00547@john.epistle>
Subject: Re: matroxfb
In-Reply-To: <130F7D5154C9@vcnet.vc.cvut.cz> from Petr Vandrovec at "Jan 20,
 2001 00:29:33 am"
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Date: Sat, 20 Jan 2001 01:20:48 +0100 (CET)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Really amazing...

1280x1024 scrolling with matroxfb was awfully slow...
With mga and agpgart it's as fast as consoles are
normally.

Next I'll try changing modes without changing to 1024x768
on loading modules and then acceleration.

Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
