Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278634AbRJXQAx>; Wed, 24 Oct 2001 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278603AbRJXQAo>; Wed, 24 Oct 2001 12:00:44 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:61202 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S278615AbRJXQA0>;
	Wed, 24 Oct 2001 12:00:26 -0400
Date: Wed, 24 Oct 2001 09:03:09 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Vitezslav Samel <samel@mail.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <20011024174010.A603@pc11.op.pod.cz>
Message-ID: <Pine.LNX.4.10.10110240902210.21638-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Works here, I just created a 130GB partition using 2.4.12.
glibc-2.2.4 running on debian.

	Gerhard

 

On Wed, 24 Oct 2001, Vitezslav Samel wrote:

> 	Hi!
> 
>   This is MeToo(tm) message. Limits set to unlimited, glibc-2.2.2 compiled
> against 2.4.0 headers.
>   Booting into 2.4.10-ac10 kernel problem "solved".
> 
> > When I try to create a partition of 2GB using fdisk or parted, I get the
> > error "File size limit exceeded (core dumped)". I already read about this
> > error on the mailing list, but sadly not of any solution.
> > 
> > Has anybody got one?
> > 
> > Btw: If happend with fdisk from util-linux-2.10f until util-linux-2.11l.
> 
>   Looking forward to proper fix.
> 
> 	Cheers,
> 		Vita
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

