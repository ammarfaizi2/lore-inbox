Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284177AbRLASDg>; Sat, 1 Dec 2001 13:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284183AbRLASD0>; Sat, 1 Dec 2001 13:03:26 -0500
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:33289 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S284174AbRLASDJ>; Sat, 1 Dec 2001 13:03:09 -0500
Subject: Re: esr cut off my genitives
From: Richard Russon <ldm@flatcap.org>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200112011714.fB1HErY09774@snark.thyrsus.com>
In-Reply-To: <200112011714.fB1HErY09774@snark.thyrsus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 01 Dec 2001 18:03:07 +0000
Message-Id: <1007229787.2134.10.camel@addlestones>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi esr,

There are a couple of lines of the patch I'm not quite happy with.

> -Windows' Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)
> +Windows Logical Disk Manager (Dynamic Disk) support (EXPERIMENTAL)

> -Windows' LDM extra logging
> +Windows LDM extra logging

Not wishing to sound too pedantic, but I did put the apostropes in on
purpose.  "Windows" is a plural noun and the genitive of it is "Windows'".

Of course if it's a limitation of the new config tool I'll understand :-)
(and you'll need to apply the following, too).

-IBM's S/390 architecture
+IBMs S/390 architecture

Cheers,
  FlatCap (Rich)
  ldm@flatcap.org





