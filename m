Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281691AbRLAV2c>; Sat, 1 Dec 2001 16:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281690AbRLAV2W>; Sat, 1 Dec 2001 16:28:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281696AbRLAV2M>; Sat, 1 Dec 2001 16:28:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: esr cut off my genitives
Date: 1 Dec 2001 13:28:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ubi11$eq5$1@cesium.transmeta.com>
In-Reply-To: <200112011714.fB1HErY09774@snark.thyrsus.com> <1007229787.2134.10.camel@addlestones>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1007229787.2134.10.camel@addlestones>
By author:    Richard Russon <ldm@flatcap.org>
In newsgroup: linux.dev.kernel
>
> Hi esr,
> 
> There are a couple of lines of the patch I'm not quite happy with.
> 
> > -Windows' Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
> > +Windows Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
> 
> > -Windows' LDM extra logging
> > +Windows LDM extra logging
> 
> Not wishing to sound too pedantic, but I did put the apostropes in on
> purpose.  "Windows" is a plural noun and the genitive of it is "Windows'".
> 
> Of course if it's a limitation of the new config tool I'll understand :-)
> (and you'll need to apply the following, too).
> 
> -IBM's S/390 architecture
> +IBMs S/390 architecture
> 

However, the use of genitives in the construction above is not really
the common usage.  However, "IBMs S/390" is completely bogus -- it
should be "IBM S/390".

Also, if the tool can't handle ' I would fix the bloody tool.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
