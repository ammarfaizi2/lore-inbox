Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314605AbSDTKme>; Sat, 20 Apr 2002 06:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314606AbSDTKmd>; Sat, 20 Apr 2002 06:42:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4618 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314605AbSDTKmd> convert rfc822-to-8bit; Sat, 20 Apr 2002 06:42:33 -0400
Date: Sat, 20 Apr 2002 03:41:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: update for {Re: [PATCHSET] Linux 2.4.19-pre7-jam1, -jam2}
In-Reply-To: <20020419232633.GA1775@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10204200335390.19117-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.6.patch.bz2

fixes hpt372
migration towards modular chipsets
devfs ide-scsi
more but can not remember
little uglyer but will collapse clean.

thanks for testing...


On Sat, 20 Apr 2002, J.A. Magallon wrote:

> 
> On 2002.04.19 Heinz Diehl wrote:
> >On Thu Apr 18 2002, J.A. Magallon wrote:
> >
> >> >I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
> >> >my machine hangs at boot time....
> >
> >> It worked for me, just booted fine with hdparm included...
> >
> >I just merged "ide-2.4.19-p7.all.convert.5.patch" into my tree, and now
> >it works also for me. With former versions my machine hung at boot time,
> >wether #if 0 or 1 was set.
> >
> 
> Just a 'me too'. Patch -5 booted fine, I have put a -jam2 in the usual place:
> 
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.3 (Cooker) for i586
> Linux werewolf 2.4.19-pre7-jam2 #1 SMP sáb abr 20 00:20:15 CEST 2002 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

