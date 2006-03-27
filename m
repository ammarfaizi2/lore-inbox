Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWC0Lop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWC0Lop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWC0Lop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:44:45 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:46095 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1750922AbWC0Loo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:44:44 -0500
Message-ID: <BAYC1-PASMTP02384285CB847B7D050BABAED20@CEZ.ICE>
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Mon, 27 Mar 2006 06:42:03 -0500
From: sean <seanlkml@sympatico.ca>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       garloff@suse.de
Subject: Re: [ANNOUNCE] OpenVZ patch for 2.6.16 and beta SUSE10.1 kernels
Message-Id: <20060327064203.24f8f607.seanlkml@sympatico.ca>
In-Reply-To: <20060327112201.GC16409@MAIL.13thfloor.at>
References: <4427B7DC.3040804@openvz.org>
	<20060327112201.GC16409@MAIL.13thfloor.at>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 27 Mar 2006 11:44:39.0575 (UTC) FILETIME=[D49D2A70:01C65193]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006 13:22:01 +0200
Herbert Poetzl <herbert@13thfloor.at> wrote:

> also the web pages 'Description of Virtuozzo(tm) benefits over OpenVZ'
> clearly state that:
> 
> Virtuozzo(TM) is SWsoft's virtualization and automation solution 
> built on top of OpenVZ. Differently from OpenVZ, Virtuozzo(TM) 
> is developed and designed to run production workloads in 24×7 
> environments and provides significant improvements and additional 
> functionality in the areas of stability, density, management tools, 
> recovery, and other areas. 

Don't think anyone is proposing this for inclusion in mainline.
And I doubt anyone wants a solution in mainline that isn't designed
for production workloads and 24x7 environments, especially if it 
has known stability problems.

> 
> Specific benefits of Virtuozzo(TM) compared to OpenVZ can be found 
> below:
> 
>   Higher VPS density. Virtuozzo^(TM) provides efficient memory and
>   file sharing mechanisms enabling higher VPS density and better
>   performance of VPSs.
> 
>   Improved Stability, Scalability, and Performance. Virtuozzo(TM) 
>   is designed to run 24×7 environments with production workloads 
>   on hosts with up-to 32 CPUs.
> 
