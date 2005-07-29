Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVG2XLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVG2XLW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVG2XIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:08:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45812 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262853AbVG2XFs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:05:48 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Date: Fri, 29 Jul 2005 19:05:36 -0400
User-Agent: KMail/1.8.1
Cc: Alexander Fieroch <fieroch@web.de>, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alexey Dobriyan <adobriyan@gmail.com>, Natalie.Protasevich@unisys.com,
       Andrew Morton <akpm@osdl.org>
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de> <42EAD086.4010904@gmail.com>
In-Reply-To: <42EAD086.4010904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507291905.37339.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 20:57, Michael Thonke wrote:
> Hello Alexander,
>
> do you run
> A.) SATA in Enhanced Mode
> B.) SATA+PATA or PATA operation mode?
>
> This problem I can reproduce when I  set A.)+B.) in bios I
> exactly get the same behavior of confused cd - drives.
>
> Greets
>
> Best regards
>              Michael

I have this same problem on my laptop which doesn't have SATA.  In my case I 
get the problem if I run 2.6.12-gentoo-r6 - Problem doesnt happen with 
2.6.12-gentoo-r4 - which just means that tracking the patch causing this 
problem will be simpler...

Parag
