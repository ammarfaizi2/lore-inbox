Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133077AbRDVSwS>; Sun, 22 Apr 2001 14:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133097AbRDVSwI>; Sun, 22 Apr 2001 14:52:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133077AbRDVSvy>; Sun, 22 Apr 2001 14:51:54 -0400
Subject: Re: 2.4.3+ sound distortion
To: v.p.p.julien@xs4all.nl (Victor Julien)
Date: Sun, 22 Apr 2001 19:53:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010422194713.A321@victor> from "Victor Julien" at Apr 22, 2001 07:47:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rOzJ-0006Mh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.4-pre6 did only compile when I aplied the '__builtin_expect'-patch. It
> crashed at boot however, when initializing my onboard raidcontroller
> (PDC20265 on a MSI K7T Turbo-R). It seems to be the same problem as
> reported by Manuel A. McLure. So no word yet about the sound
> distortion-problem being fixed.

I've sent Linus a fix for the PDC20265 crash
