Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289110AbSAJCMQ>; Wed, 9 Jan 2002 21:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289119AbSAJCMG>; Wed, 9 Jan 2002 21:12:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289110AbSAJCLy>; Wed, 9 Jan 2002 21:11:54 -0500
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97
To: salvador@inti.gov.ar
Date: Thu, 10 Jan 2002 02:23:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C3C8093.7213A219@inti.gov.ar> from "salvador" at Jan 09, 2002 02:40:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OUsF-00035V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also a card can have multiple ac97 codecs
> 
> You are right, will also take care about it. Do you think
> /proc/driver/{vendor}/{dev_pci}/{num_ac97}/ac97 will be ok?

I'm dubious about the entire /proc entries. 8)
