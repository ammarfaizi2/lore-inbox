Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290479AbSAQVqU>; Thu, 17 Jan 2002 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290482AbSAQVqA>; Thu, 17 Jan 2002 16:46:00 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:61946 "EHLO fep6.cogeco.net")
	by vger.kernel.org with ESMTP id <S290479AbSAQVp7>;
	Thu, 17 Jan 2002 16:45:59 -0500
Subject: Re: hangs using opengl
From: "Nix N. Nix" <nix@go-nix.ca>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201171926.g0HJQUE19410@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <3C4712DB.6090201@kabelfoon.nl> <1011292729.12873.27.camel@tux>
	<1011294257.13517.1.camel@tux> 
	<200201171926.g0HJQUE19410@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 16:45:00 -0500
Message-Id: <1011303957.15470.7.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 18:26, Denis Vlasenko wrote:
> 
> Athlon bug stomper is already in mainline. If latest kernel does not work for 
> you, check that register (man lspci) and 0x95 also. Try to disable them (man 
> setpci). Report back - we may need to further improve stomper.

Uh-oh !  agpgart says I have an VIA Apollo Pro KT266 chipset, but
NVdriver says I have a VIA Apollo KT133 chipset.  Is that OK ?  Could
that be causing my problems ?



Thanks for all the help & info.

> --
> vda
> 


