Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311367AbSCSOof>; Tue, 19 Mar 2002 09:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311366AbSCSOoZ>; Tue, 19 Mar 2002 09:44:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60682 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311365AbSCSOoL>; Tue, 19 Mar 2002 09:44:11 -0500
Subject: Re: amd nvidia and mem=nopentium
To: Nicolas.Turro@sophia.inria.fr (Nicolas Turro)
Date: Tue, 19 Mar 2002 15:00:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Nicolas.Turro@sophia.inria.fr (Nicolas Turro),
        linux-kernel@vger.kernel.org
In-Reply-To: <200203191419.g2JEJfM07465@atlas.inria.fr> from "Nicolas Turro" at Mar 19, 2002 03:19:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nL60-0007uF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> choice on the configuration. I have to choose between this config
> and a dual 2.0 Ghz Xeon (RDRAM) which has roughtly the same perfs,
> but which is 50% more expensive !

I'd go Athlon

>  Do you have pointers  showing stability problems when using
> XP processor in a multiprocessor context ?

Remember the XP's haven't been tested in MP configurations (or tested and
failed). The same was true of celerons and as most people found the fail
rate was pretty low 8)

Alan

