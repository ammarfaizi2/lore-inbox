Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSEMWiz>; Mon, 13 May 2002 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314513AbSEMWiy>; Mon, 13 May 2002 18:38:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11012
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314512AbSEMWix>; Mon, 13 May 2002 18:38:53 -0400
Date: Mon, 13 May 2002 15:36:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Phillip.Watts@nlynx.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Compact Flash bug
In-Reply-To: <86256BB8.0077508C.00@nlynx.com>
Message-ID: <Pine.LNX.4.10.10205131534470.15295-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not an issue since at the change from SunDisk to SanDisk, the updated the
identify page of the device to correspond to a flash signature.

On Mon, 13 May 2002 Phillip.Watts@nlynx.com wrote:

> 
> 
> in 2.4.18  the routine which is determining if Compact Flash
> has  Sandisk  spelled SunDisk.
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

