Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316264AbSEKTPD>; Sat, 11 May 2002 15:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316265AbSEKTPC>; Sat, 11 May 2002 15:15:02 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54033
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316264AbSEKTPB>; Sat, 11 May 2002 15:15:01 -0400
Date: Sat, 11 May 2002 12:12:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 60
In-Reply-To: <3CDD6749.6080209@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10205111210320.3133-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to specify which of the 6 revisions of the chipset you have.
Also in some cases which of the 13 sub-revisions, and the latter is
determined by the sub-vender-device.

On Sat, 11 May 2002, Pierre Rousselet wrote:

> Martin Dalecki wrote:
>  > Fri May 10 16:17:01 CEST 2002 ide-clean-60
>  >
>  > Synchronize with 2.5.15
>  >
>  > - Rewrite ioctl handling.
>  >
>  > - Apply fix for hpt366 "hang on boot" by Andre.
> 
> No, it doesn't fix it for me.
> 
> -- 
> Pierre
> ------------------------------------------------
>    Pierre Rousselet <pierre.rousselet@wanadoo.fr>
> ------------------------------------------------
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

