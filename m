Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314542AbSDSEFB>; Fri, 19 Apr 2002 00:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314543AbSDSEFA>; Fri, 19 Apr 2002 00:05:00 -0400
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:18129 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314542AbSDSEFA> convert rfc822-to-8bit; Fri, 19 Apr 2002 00:05:00 -0400
Message-ID: <3CBF996D.1070900@wanadoo.fr>
Date: Fri, 19 Apr 2002 06:13:33 +0200
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide-2.4.19-p7.all.convert.5.patch
In-Reply-To: <Pine.LNX.4.10.10204182030140.17538-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.5.patch.bz2
> 
> This now has clean taskfile io tested on two archs.
> 
> Both PowerMac UP and x86 all appear stable with taskfile io enabled.
> PPC well generate a random missed interrupt in mult-mode pio on a sync
> call but it never misses a beat or hangs.
> 
> Feed back from a few people have stated Sparc ?? amnd PPC64 appear stable.
> 
> IA-64 is the only know broken arch.  Since returning the heater^WItanic^box 
> testing various hardware there is not practical.
> 
> Cheers and Complain if it does not work.

Testing begins immediately on 3 different comps (x86) with
different IDE controllers and hard drives.

> Andre Hedrick
> LAD Storage Consulting Group

I'll report any bugs / unusual behaviour.

François Cami


