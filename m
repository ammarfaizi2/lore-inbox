Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287894AbSAHFKA>; Tue, 8 Jan 2002 00:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287648AbSAHFJk>; Tue, 8 Jan 2002 00:09:40 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:5243 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S287885AbSAHFJf>; Tue, 8 Jan 2002 00:09:35 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200201080201.g0821tT25111@devserv.devel.redhat.com>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
To: jamagallon@able.es (J.A. Magallon)
Date: Mon, 7 Jan 2002 21:01:55 -0500 (EST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        hch@ns.caldera.de (Christoph Hellwig), perex@suse.cz (Jaroslav Kysela),
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020108004416.A23665@werewolf.able.es> from "J.A. Magallon" at Jan 08, 2002 12:44:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would't it be better to split drivers:
> 
> sound/core.c
> sound/alsa/alsa-core.c
> sound/alsa/drivers/alsa-emu10k.c
> sound/oss/oss-core.c
> sound/oss/drivers/oss-emu10k.c

Thats much harder to do randomg greps on and to find stuff,than drivers
first
