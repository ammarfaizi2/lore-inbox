Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBOLoj>; Thu, 15 Feb 2001 06:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBOLo3>; Thu, 15 Feb 2001 06:44:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52741 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129051AbRBOLoS>; Thu, 15 Feb 2001 06:44:18 -0500
Subject: Re: aic7xxx plans
To: wakko@animx.eu.org (Wakko Warner)
Date: Thu, 15 Feb 2001 11:44:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010214210351.B21191@animx.eu.org> from "Wakko Warner" at Feb 14, 2001 09:03:51 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TMpq-0007sY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I forget the location, where can I get this patch?  I'm running 2.4.1 on an
> alpha which has nothing but problems with the aha-2940uw card I have
> installed.

You would do. The AIC7xxx driver in 2.4 < 2.4.1ac10 or so is not 64bit clean
Give 2.4.1ac12 a spin or try Justins driver (dont have the URL handy)

