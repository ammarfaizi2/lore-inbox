Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135704AbREBRxv>; Wed, 2 May 2001 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135696AbREBRxi>; Wed, 2 May 2001 13:53:38 -0400
Received: from mnh-1-08.mv.com ([207.22.10.40]:12040 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S135704AbREBRxX>;
	Wed, 2 May 2001 13:53:23 -0400
Message-Id: <200105021906.OAA03542@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: ingo.oeser@informatik.tu-chemnitz.de
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Wed, 02 May 2001 17:55:16 +0100."
             <E14uzuI-0003wC-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 May 2001 14:06:31 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> > Is this sufficient to do driver development?  TUN/TAP doesn't let me
> > write 
> > ethernet drivers inside UML.
> For ISDN not really. For SCSI yes - scsi generic would let you write a
> virtual scsi adapter 'owning' some physical devices 

Fine, so go ahead and write a UML SCSI adapter...  

I would love to see this happen.  If you need UML help that's not on the site, 
let me know, and I'll be happy to do what I can.

				Jeff


