Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285849AbRLHGlv>; Sat, 8 Dec 2001 01:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbRLHGla>; Sat, 8 Dec 2001 01:41:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14604 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285849AbRLHGlG>; Sat, 8 Dec 2001 01:41:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.17-pre6
Date: 7 Dec 2001 22:40:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9uscli$q5k$1@cesium.transmeta.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7CE@orsmsx111.jf.intel.com> <20011207221436.B24098@asooo.flowerfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011207221436.B24098@asooo.flowerfire.com>
By author:    Ken Brownfield <brownfld@irridia.com>
In newsgroup: linux.dev.kernel
>
> Not a problem at all.  That's what -pre releases and folks testing with
> ancient (but tried and tested) releases are for. ;-)
> 
> It sounds like it's easily revertable, but maybe it's worth putting the
> axe in egcs compatibility for other people? ... Dunno.
> 

It's worth putting the axe in when you have a good reason to break
compatibility.  This, however, isn't one of those.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
