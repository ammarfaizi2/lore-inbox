Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288466AbSANAlI>; Sun, 13 Jan 2002 19:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSANAlA>; Sun, 13 Jan 2002 19:41:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288466AbSANAki>; Sun, 13 Jan 2002 19:40:38 -0500
Subject: Re: Getting Out of Memory errors at random intervals.
To: abrink@ns.brink.cx (Andrew Brink)
Date: Mon, 14 Jan 2002 00:52:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020114003907.GB1406@ns.brink.cx> from "Andrew Brink" at Jan 13, 2002 06:39:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PvMS-00005i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 14, 2002 at 12:44:51AM +0000, Alan Cox wrote:
> > > *Shrug* I've done some experimenting with this, having a lab (30 people)
> > > all hit the site at the same time. Holds it fine most the time.  Usually
> > > the OOM's come during the middle of the night.
> > 
> > About 4am by any chance ?
> 
> On second thought, I went and reviewed some logs.
> Happened a lot on one box around 8ish.
> 

Ok. Let me know how trying the other things work (also the list). I'm sure
Andrea, Marcelo and Rik all want to look at these cases
