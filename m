Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317264AbSFLAJg>; Tue, 11 Jun 2002 20:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317265AbSFLAJf>; Tue, 11 Jun 2002 20:09:35 -0400
Received: from p50886B65.dip.t-dialin.net ([80.136.107.101]:7301 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317264AbSFLAJe>; Tue, 11 Jun 2002 20:09:34 -0400
Date: Tue, 11 Jun 2002 18:09:19 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Roland Dreier <roland@topspin.com>
cc: Thunder from the hill <thunder@ngforever.de>,
        "David S. Miller" <davem@redhat.com>, <oliver@neukum.name>,
        <wjhun@ayrnetworks.com>, <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
In-Reply-To: <52d6ux5q01.fsf@topspin.com>
Message-ID: <Pine.LNX.4.44.0206111808190.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11 Jun 2002, Roland Dreier wrote:
> I left out the error checking for the allocations everywhere in my
> email.  It wasn't real code and I thought that testing for NULL all
> over the place would obscure the real point.

Sure thing. It was just my newly introduced paranoia, I have some things 
like them to fix.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

