Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSKBV3M>; Sat, 2 Nov 2002 16:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSKBV3M>; Sat, 2 Nov 2002 16:29:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56974 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261429AbSKBV3K>;
	Sat, 2 Nov 2002 16:29:10 -0500
Date: Sat, 2 Nov 2002 21:25:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Nero <neroz@iinet.net.au>, Romain Lievin <rlievin@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102212541.GA2567@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Nero <neroz@iinet.net.au>, Romain Lievin <rlievin@free.fr>,
	linux-kernel@vger.kernel.org
References: <20020625222135.GA617@free.fr> <3DC378D0.5080703@iinet.net.au> <20021102203608.GB731@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102203608.GB731@gallifrey>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 08:36:08PM +0000, Dr. David Alan Gilbert wrote:

 > > Yes please :)
 > > GTK+ is probably the most common (decent) toolkit out there - nearly any 
 > > system with X has it installed, from what I've seen.
 > Oh please....
 > Wouldn't it be more helpful to iron the (few) small glitches out of the
 > qt based one than write a new one just because you don't happen to like
 > the library?

Linus mentioned this a while ago. This kind of holy war is going to
happen regardless of the library used. There's no reason that a
GTK config tool would have to be merged anyway, it could live
as a seperate project (as could the qt one really imo), outside
the kernel sources.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
