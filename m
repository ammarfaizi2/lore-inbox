Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286380AbRL0ReI>; Thu, 27 Dec 2001 12:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286381AbRL0Rd7>; Thu, 27 Dec 2001 12:33:59 -0500
Received: from cs136068.pp.htv.fi ([213.243.136.68]:902 "EHLO
	limbo.dnsalias.org") by vger.kernel.org with ESMTP
	id <S286380AbRL0Rdq>; Thu, 27 Dec 2001 12:33:46 -0500
Date: Thu, 27 Dec 2001 19:33:36 +0200 (EET)
From: Timo Jantunen <jeti@iki.fi>
To: <Andries.Brouwer@cwi.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <UTC200112271542.PAA121704.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.33.0112271920260.991-100000@limbo.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 Andries.Brouwer@cwi.nl wrote:

>> Most disk sizes are an unholy mixture of the two
>> that deserves a stake through the heart,
>> where 1 GB = 1,024,000,000 bytes.
> "Are"??
> 
> I see several good people spout this particular type of nonsense
> here. If I interpret "are" to mean that that is the unit
> disk manufacturers use, then it is false - as far as I know
> no manufacturer uses this.

How about IBM. According to the datasheet at
http://www.storage.ibm.com/hdd/desk/ds120gxp.htm

Deskstar 120GXP with 120GB capacity has 24125472 sectors (123522416640
bytes).

That is 123.5GB if G=10^9 but 120.6GB if G=10^6*2^10 (and merely 115.0GB 
if G=2^30).

Horrible? Yes.

(The same is true for 40GB and 80GB versions of 120GXP, and my (older model)
30GB and 40GB IBM drives.)


> Let us look at Maxtor. They are so friendly to give disk size
> as part of the type.
> Maxtor 91728D8 - 17280442368 bytes, 17280 MB, 17.2 GB
> Maxtor 93652U8 - 36529274880 bytes, 36529 MB, 36.5 GB
> Maxtor 96147H6 - 61473226752 bytes, 61473 MB, 61.4 GB
> 
> You see that the number of GB claimed by the manufacturer is
> just (number of megabytes)/1000.
> There is no 2.4% difference that could justify your strange claim.

So Maxtor lies 7.37% while IBM lies only 4.86%?


BTW does anybody else remember when this insanity started? I seem to remember
that in the begining of the 90's some manufacturers re-defined (binary) MB as
1000kB and others had to follow (most likely because stupid buyers usually
bought the drive with 2.4% bigger figure without realizing it was the same
size as the other.)


> Andries

// /

