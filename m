Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316607AbSFDMzz>; Tue, 4 Jun 2002 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSFDMzy>; Tue, 4 Jun 2002 08:55:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17655 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316607AbSFDMzx>; Tue, 4 Jun 2002 08:55:53 -0400
Subject: Re: sis_main.c compile error in 2.4.19-pre10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Thomas Winischhofer <thomas@winischhofer.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0206041329370.8847-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 15:01:32 +0100
Message-Id: <1023199292.23874.136.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 13:41, Adrian Bunk wrote:
>
> sis_main.c:3276: structure has no member named `mtrr'
> make[4]: *** [sis_main.o] Error 1
> make[4]: Leaving directory
> `/home/bunk/linux/kernel-2.4/linux-full/drivers/video/sis'
> 
> <--  snip  -->
> 
> 
> It seems the following patch that from 2.4.19-pre9-ac3 is needed?

My fault. I missed that bit when sending it on to Marcelo

