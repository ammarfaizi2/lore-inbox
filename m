Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280801AbRKLOYS>; Mon, 12 Nov 2001 09:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280803AbRKLOYI>; Mon, 12 Nov 2001 09:24:08 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:23346 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280801AbRKLOXu>; Mon, 12 Nov 2001 09:23:50 -0500
Date: Mon, 12 Nov 2001 16:23:37 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Caulfield <caulfield@sistina.com>, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [PATCH] lvm in 2.4.15.pre3
Message-ID: <20011112162337.J26218@niksula.cs.hut.fi>
In-Reply-To: <20011112130101.A11020@tykepenguin.com> <E163GzN-0005po-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E163GzN-0005po-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 12, 2001 at 01:19:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 01:19:01PM +0000, you [Alan Cox] claimed:
> > Please apply the following patch to LVM in 2.4.13pre3.
> > 
> > It looks like the LVM patch that came from Alan calls alloc/free_kiovec_sz()
> > functions which only exist in his tree.
> 
> Just sent Linus the same thing 8)

Sorry if this is a FAQ, but I see the LVM in .15pre3 is 0.9.1beta2. Are there
plans to merge something newer like 1.0.1pre4? 

What about Andreas Dilger's fixes? Do they get the pre3 LVM closer to
1.0.1pre4?


-- v --

v@iki.fi
