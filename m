Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285329AbRLSPpT>; Wed, 19 Dec 2001 10:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285330AbRLSPpJ>; Wed, 19 Dec 2001 10:45:09 -0500
Received: from ntmail.avint.net ([198.165.75.239]:3592 "EHLO NTMAIL.avint.net")
	by vger.kernel.org with ESMTP id <S285329AbRLSPow>;
	Wed, 19 Dec 2001 10:44:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Brendan Pike <spike@superweb.ca>
Reply-To: spike@superweb.ca
Organization: Linux User
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Date: Wed, 19 Dec 2001 11:44:47 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
In-Reply-To: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
MIME-Version: 1.0
Message-Id: <01121911444703.31762@spikes>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 11:32 am, Thomas Deselaers wrote:
> Hello,
>
> I do have an Asus P2B-S Mainboard and since a week I have a Maxtor 60 GB
> 5400 rpm Harddrive (MAXTOR 4K060H3).
>
> I tried the performance of the drive and got some results which are quite
> low I think.
>
> hdparm -t /dev/hdc returns
>
> /dev/hdc:
>  Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
>
> What would be a value I can expect from my hardware? And what might result
> in higher speeds?
>
> thanks,
> thomas

I dont really know, I dont think its possible to get higher then that from a 
5400 RPM disk. Heres mine,

FUJITSU 40.9GB MPG3409AT 5400 RPM

/dev/hda:
Timing buffered disk reads:  64 MB in  7.96 seconds =  8.04 MB/sec
/dev/hda:
Timing buffered disk reads:  64 MB in  7.07 seconds =  9.05 MB/sec
/dev/hda:
Timing buffered disk reads:  64 MB in  6.70 seconds =  9.55 MB/sec

Seems pretty normal to me. However yours is alot better then mine.
