Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281947AbRKZUcl>; Mon, 26 Nov 2001 15:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbRKZUcV>; Mon, 26 Nov 2001 15:32:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281947AbRKZUcS>; Mon, 26 Nov 2001 15:32:18 -0500
Subject: Re: New ac patch???
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Mon, 26 Nov 2001 20:39:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), marcel@mesa.nl (Marcel J.E. Mol),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <9CF08CC6C77@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Nov 21, 2001 01:29:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E168SXh-0006n3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks. It seems IBM laptop drives are the ones that specifically need this
> > fix. That ties in with the windows 98 reports/microsoft fixes.
> 
> If it will go into mainstream, please change it to config option or
> something like that. I'm doing 
> 
> for a in /dev/hd[a-z]; do hdparm -Y $a; done

Thats somewhat undefined in its behaviour. You might also page after the
hdparm -Y
