Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276256AbRJGKF4>; Sun, 7 Oct 2001 06:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276271AbRJGKFq>; Sun, 7 Oct 2001 06:05:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37380 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276256AbRJGKFf>; Sun, 7 Oct 2001 06:05:35 -0400
Subject: Re: CPU Temperature?
To: harri@synopsys.COM
Date: Sun, 7 Oct 2001 11:10:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), goemon@anime.net (Dan Hollis),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BC0191F.C0085955@Synopsys.COM> from "Harald Dunkel" at Oct 07, 2001 10:58:07 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qAsz-0005PE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course I would be interested to get the lm_sensors included in the
> kernel, too. Is this still an option for 2.4.x? 

It doesnt break the machine, replace key parts of the core of the system or 
change critical interfaces. By conventional standards its ok, by 2.4.10 
standards its not a candidate 8)

I'm certainly prepared to go through the files trying to poke holes in them
and its stuff I think just about every vendor already ships anyway
