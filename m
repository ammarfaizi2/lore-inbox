Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315488AbSECAWd>; Thu, 2 May 2002 20:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315489AbSECAWc>; Thu, 2 May 2002 20:22:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15123 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315488AbSECAWb>; Thu, 2 May 2002 20:22:31 -0400
Subject: Re: Linux 2.4.19-pre8
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Fri, 3 May 2002 01:41:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0205021845430.10896-100000@freak.distro.conectiva> from "Marcelo Tosatti" at May 02, 2002 06:51:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173R8b-0005H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <santiago@newphoenix.net> (02/04/05 1.383.1.1)
> 	Update OSS ac97_codec driver to add special init and control

Barf. Please update the drivers that touches and make him the maintainer,
ditto all other AC97 using code. Thats a hack I refuse to support or be
involved in the perpetration of.

