Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbRFGSYt>; Thu, 7 Jun 2001 14:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbRFGSYj>; Thu, 7 Jun 2001 14:24:39 -0400
Received: from penguins-world.pcsystems.de ([212.63.44.200]:33006 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S262728AbRFGSYV>;
	Thu, 7 Jun 2001 14:24:21 -0400
Message-ID: <3B1FC6B6.A66CC96B@pcsystems.de>
Date: Thu, 07 Jun 2001 20:23:50 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <20010607191645.A17205@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW wrote:

> On Thu, Jun 07, 2001 at 06:22:59PM +0200, Nico Schottelius wrote:
>
> >  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >  I/O error: dev 08:01, sector 127304
> > SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 8000002
> > [valid=0] Info fld=0x0, Current sd08:01: sns = 70  b
> > ASC=47 ASCQ= 0
> > Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x18 0x00 0x00 0x00 0x00 0x47 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> >  I/O error: dev 08:01, sector 127312
>
> Aborted command: SCSI parity error.

Hmm...what to do against this ?
the 'disable parity' jumper is not set, should I set it ?

Or was this something to adjust in the boot up adaptec
menu ?

Whatever, thanks a lot to here !

Nico

