Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSGSJud>; Fri, 19 Jul 2002 05:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318515AbSGSJuc>; Fri, 19 Jul 2002 05:50:32 -0400
Received: from imeil.udg.es ([130.206.45.97]:15782 "EHLO imeil.udg.es")
	by vger.kernel.org with ESMTP id <S318514AbSGSJu3>;
	Fri, 19 Jul 2002 05:50:29 -0400
Date: Fri, 19 Jul 2002 11:56:41 +0200 (CEST)
From: Giro <giro@hades.udg.es>
To: support <support@promise.com.tw>
Cc: "Alan Cox (Linux Kernel)" <alan@lxorguk.ukuu.org.uk>,
       "Marcelo (Linux Kernel)" <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
In-Reply-To: <Pine.LNX.4.30.0207191151230.15842-100000@hades.udg.es>
Message-ID: <Pine.LNX.4.30.0207191154280.16106-100000@hades.udg.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Giro wrote:

>
> I test this patch, and have compile problem with one } on ide.c

Sorry error on line 918

and more errors:
drivers/ide/idedriver.o: In function `ide_error':
drivers/ide/idedriver.o(.text+0x3b37): undefined reference to
`pdc202xx_marvell_idle'


i use 2.4.18 + patch-2.4.19-rc2 + patch-2.4.19-rc2-ac2 +
promise-patch-2.4.19-rc2-ac2

i supous it is correct?


Giro



>

>
giro
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

*******************************************************************************
  David Gironella Casademont
  Estudiant Informatica de Sistemes - Universitat de Girona
  Administrador d'Hades root@hades.udg.es
  Secretari Associació d'Estudiants d'Informàtica de Girona AEIGI
  AEIGi Web - http://www.aeigi.org
  Giro Web - http://hades.udg.es/~giro
*******************************************************************************




