Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287681AbSBCUIe>; Sun, 3 Feb 2002 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSBCUIY>; Sun, 3 Feb 2002 15:08:24 -0500
Received: from user-24-214-12-221.knology.net ([24.214.12.221]:16013 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S287681AbSBCUIW>; Sun, 3 Feb 2002 15:08:22 -0500
Message-ID: <00ba01c1acee$9494acd0$ed00000a@citrix.bjstuff.com>
From: "Ro0tSiEgE" <ro0tsiege@bjstuff.com>
To: "jeev" <naptime@cervnet.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000001c1ac7e$07899b40$0200a8c0@mainframe>
Subject: Re: Booting Issue
Date: Sun, 3 Feb 2002 14:08:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But I didn't remove ANYTHING from the default config, just added stuff.
----- Original Message ----- 
From: "jeev" <naptime@cervnet.com>
To: "'Ro0tSiEgE'" <ro0tsiege@bjstuff.com>
Sent: Sunday, February 03, 2002 12:42 AM
Subject: RE: Booting Issue


> When I had some sort of issue like this, it was because I removed some
> needed part in the config. Try using a default config then slowly
> removing stuff you know you don't need/have.
> 
> j
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of Ro0tSiEgE
> > Sent: Saturday, February 02, 2002 3:28 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: Booting Issue
> > 
> > I have a big booting issue. Apparently, it's something in my config
> file,
> > that makes my kernel panic saying no init found. Now even though I
> have
> > some
> > external patches applied, I know that can't be the issue because I've
> > tried
> > the same config without the patches. If somebody could PLEASE look at
> my
> > config and tell me what I'm doing wrong, I've been fighting with this
> > problem for over a month, every kernel I've tried to make, no matter
> what
> > version, with or without any patches, says I have no init found. But
> > kernels
> > I've made in the past work fine, so I'm thinking it's gotta be
> something
> > with my config. Please look at my config (this is 2.4.18-pre7-ac2),
> its
> > posted at: http://www.bjstuff.com/config
> > 
> > Thanks very much,
> > 
> > Brad Parker
> > 
> > 
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


