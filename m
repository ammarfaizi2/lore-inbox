Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270344AbRHMRyj>; Mon, 13 Aug 2001 13:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270343AbRHMRy2>; Mon, 13 Aug 2001 13:54:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270344AbRHMRyP>; Mon, 13 Aug 2001 13:54:15 -0400
Subject: Re: 2.4.8-ac2 USB keyboard capslock hang
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Mon, 13 Aug 2001 18:56:48 +0100 (BST)
Cc: braam@clusterfilesystem.com (Peter J. Braam), linux-kernel@vger.kernel.org
In-Reply-To: <20010813131143.G3126@sventech.com> from "Johannes Erdfelt" at Aug 13, 2001 01:11:43 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WLxI-0007tC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 13, 2001, Peter J. Braam <braam@clusterfs.com> wrote:
> > I have a Logitech Internet USB keyboard, attached to an IBM TP T20. 
> > 
> > In the above system pressing Caps lock twice (i.e. switching capslock
> > off) freezes the system completely. 
> > 
> > The last system that didn't do so for me was Rosswell's kernel. 
> > Does anyone know about this?  Thanks a lot!
> 
> Rosswell?

Roswell is the Red Hat 7.2 beta, so its probably another bug that was fixed
in the USB and input updates in -ac
