Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBGWih>; Wed, 7 Feb 2001 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130086AbRBGWi2>; Wed, 7 Feb 2001 17:38:28 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:6660 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129250AbRBGWiP>; Wed, 7 Feb 2001 17:38:15 -0500
Date: Thu, 8 Feb 2001 09:37:46 +1100
From: CaT <cat@zip.com.au>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspecious ide hdparm results with 2.4.1 (and a minor capacity question)
Message-ID: <20010208093746.A365@zip.com.au>
In-Reply-To: <UTC200102071744.SAA01848.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200102071744.SAA01848.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Feb 07, 2001 at 06:44:34PM +0100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 06:44:34PM +0100, Andries.Brouwer@cwi.nl wrote:
> > It's currently in LBA mode (I believe) and that, to my knowledge,
> > wastes the most space.
> 
> There are two entirely different things both called LBA.
> Neither of them wastes any space.

You sure? I admit to not having much knowledge of this but BIOS always
reports different sized for LBA, NORMAL and LARGE. This is what I'm
referring to.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
