Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRA1V35>; Sun, 28 Jan 2001 16:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRA1V3r>; Sun, 28 Jan 2001 16:29:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7179 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129485AbRA1V3e>; Sun, 28 Jan 2001 16:29:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CPU error codes
Date: 28 Jan 2001 13:29:09 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9522v5$7c6$1@cesium.transmeta.com>
In-Reply-To: <E14LbJ2-0008Be-00@the-village.bc.nu> <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk>
By author:    James Sutherland <jas88@cam.ac.uk>
In newsgroup: linux.dev.kernel
>
> On Thu, 25 Jan 2001, Alan Cox wrote:
> 
> > > I was wondering if someone could tell me where I can find
> > > Xeon Pentium III cpu error messages/codes
> > 
> > In the intel databook. Generally an MCE indicates hardware/power/cooling
> > issues
> 
> Doesn't an MCE also cover some hardware memory problems - parity/ECC
> issues etc?
> 

Not main memory, but it does include cache errors.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
