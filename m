Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQKMRCp>; Mon, 13 Nov 2000 12:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129192AbQKMRCg>; Mon, 13 Nov 2000 12:02:36 -0500
Received: from 214-VALL-X7.libre.retevision.es ([62.83.213.214]:1152 "EHLO
	looping.es") by vger.kernel.org with ESMTP id <S129177AbQKMRCQ>;
	Mon, 13 Nov 2000 12:02:16 -0500
Date: Mon, 13 Nov 2000 15:31:03 +0100
From: Ragnar Hojland Espinosa <ragnar_hojland@eresmas.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Michele Iacobellis <miacobellis@linuximpresa.it>,
        linux-kernel@vger.kernel.org
Subject: Re: No tcp connection establishment with 2.4
Message-ID: <20001113153103.B26814@macula.net>
In-Reply-To: <20001109110354.872F0186@linuximpresa.it> <20001109121321.P20883@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.95.6i
In-Reply-To: <20001109121321.P20883@arthur.ubicom.tudelft.nl>; from Erik Mouw on Thu, Nov 09, 2000 at 12:13:21PM +0100
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://maculaisdeadsoimmovingit/lightside
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 12:13:21PM +0100, Erik Mouw wrote:
> On Thu, Nov 09, 2000 at 12:08:32PM +0100, Michele Iacobellis wrote:
> > [Summary]
> > No tcp connection establishment with 2.4
> > 
> [snip]
> 
> Disable "Explicit congestion notification support" in the networking
> options. It breaks with certain Cisco firewalls.

Actually, it does not break with cisco firewalls;  cisco firewall
configurations are the ones broken .. :)

-- 
____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
\ o.O|                                                   2F0D27DE025BE2302C
 =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
   U     chaos and madness await thee at its end."       hkp://keys.pgp.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
