Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSKCD6n>; Sat, 2 Nov 2002 22:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSKCD6n>; Sat, 2 Nov 2002 22:58:43 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:16835 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261614AbSKCD60>; Sat, 2 Nov 2002 22:58:26 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC8D3@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [half-joke] Help - someone turned my machine into xt emulatin
	g 386 using bochs...
Date: Sat, 2 Nov 2002 20:04:16 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [Just before "incident", I turned of sharp zaurus; maybe it was
> connected using usbnet and now uhci is eating all the bandwidht?
> Anyone seen this before?]

When I was coding the early USB drivers and trying to enable UHCI
bandwitdth reclamation, that was a very common sympton of it not 
working as it should ... damn, it took me a while to figure it out,
and then I felt the most stupid person :) (thanks to Alan Cox, who
pointed me to the obvious) ...

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
