Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132214AbRAaPCm>; Wed, 31 Jan 2001 10:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRAaPCW>; Wed, 31 Jan 2001 10:02:22 -0500
Received: from staff0130.dada.it ([195.110.97.130]:6283 "EHLO
	blacksheep.at.dada.it") by vger.kernel.org with ESMTP
	id <S132121AbRAaPCJ>; Wed, 31 Jan 2001 10:02:09 -0500
Date: Wed, 31 Jan 2001 15:55:10 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: Robert Kaiser <rob@sysgo.d.redhat.com>
cc: linux-kernel@vger.kernel.org, eccesys@topmail.de
Subject: Re: Disk is cheap?
In-Reply-To: <01013114393200.01502@rob>
Message-ID: <Pine.LNX.4.10.10101311550150.3588-100000@blacksheep.at.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built a embedded dvd/cdda/mp3 player based on linux, using a p200mmx
with 24mb with a bus of 75mhx, but it still takes about 20 seconds to boot,
I think that an embedded device (for home use) should boot in less than
5 seconds, how could be possible with a slow p133? (I've also tried a p133
on 66mhz of bus and it takes almost 35 seconds to boot)
However, first or last old hardware will finish, and who wants to build
an embedded device should use high cost embedded hardware (high cost for me).

P.

On Wed, 31 Jan 2001, Robert Kaiser wrote:

> 
> > Everyone who says, disk is cheap, ought to donate me one.
> > Everyone who says, memory is cheap, has to send me some.
> 
> :-)
> 
> Perhaps a more convincing argument may be that in embedded devices,
> disk as well as memory and CPU power are _not_ cheap.
> 
> The more resources Linux requires, the less are it's chances of being
> accepted as a viable alternative in embedded systems.
> 
> > I'm still stuck with a P-133, 56 MB RAM (60-70 ns, some EDO,
> > some FPM) and not only Linux but also W2K on a 2.1 and a 0.8 GB
> > HDD.
> 
> That would be _a_ _lot_ for an embedded system!
> 
> ----------------------------------------------------------------
> Robert Kaiser                         email: rkaiser@sysgo.de
> SYSGO RTS GmbH
> Am Pfaffenstein 14                    phone: (49) 6136 9948-762
> D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
