Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRKNDLt>; Tue, 13 Nov 2001 22:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280034AbRKNDLj>; Tue, 13 Nov 2001 22:11:39 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:27087 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S280031AbRKNDLc>; Tue, 13 Nov 2001 22:11:32 -0500
Message-Id: <200111140311.fAE3BfW07279@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: What Athlon chipset is most stable in Linux?
Date: Tue, 13 Nov 2001 22:11:29 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111131559580.8219-100000@rtlab.med.cornell.edu> <200111132137.fADLbdW01289@demai05.mw.mediaone.net> <20011113.183256.15406047.davem@redhat.com>
In-Reply-To: <20011113.183256.15406047.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original question was for a cluster (of, presumably, servers).
If you're playing a quake client on an application server, you deserve 
what you get.

	-- Brian

On Tuesday 13 November 2001 09:32 pm, David S. Miller wrote:
>    From: Brian <hiryuu@envisiongames.net>
>    Date: Tue, 13 Nov 2001 16:37:28 -0500
>
>    We've tried a number of boards for our application servers and the
> only UP AMD DDR board I trust right now is the Gigabyte GA-7DX.  They
> are rock solid.
>
> Try to use the AGP slot with a Radeon of GeForce card, do something
> as simple as playing some quake with com_maxfps > 85 and the machine
> will hang solidly.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
