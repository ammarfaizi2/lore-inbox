Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSFCO4J>; Mon, 3 Jun 2002 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSFCO4I>; Mon, 3 Jun 2002 10:56:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:30609 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317387AbSFCO4G>;
	Mon, 3 Jun 2002 10:56:06 -0400
Date: Mon, 3 Jun 2002 16:55:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Derek Vadala <derek@cynicism.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
Message-ID: <20020603165549.A27667@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net> <20020603113128.C13204@ucw.cz> <3CFB82A0.EB2062AE@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 04:52:16PM +0200, Kasper Dupont wrote:

> > He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
> > be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
> > arrays)), can withstand any two disks failing anytime.
> 
> It can actually withstand any *three* disks failing anytime.

Yes, you're right.

> > Even more for
> > certain combinations. But it is terribly inefficient.

-- 
Vojtech Pavlik
SuSE Labs
