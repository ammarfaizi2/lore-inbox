Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbTCRJBB>; Tue, 18 Mar 2003 04:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTCRJBA>; Tue, 18 Mar 2003 04:01:00 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:19600 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262241AbTCRJA5>; Tue, 18 Mar 2003 04:00:57 -0500
Date: Tue, 18 Mar 2003 20:12:19 +1100
From: CaT <cat@zip.com.au>
To: Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
Message-ID: <20030318091219.GD504@zip.com.au>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com> <20030318052257.GB635@zip.com.au> <20030318091516.A3491@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318091516.A3491@lst.de>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 09:15:16AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 18, 2003 at 04:22:57PM +1100, CaT wrote:
> > The help and the tristate seems to indicate that I should be able to
> > compile it into the kernel, but menuconfig wont let me. This is
> > presumably due to the dependancy but is it right?
> 
> I think all pcmcia drivers currently are compilable only as module.

All the others I've used can be compiled in.

> This was because historically they need cardmgr to work properly, but
> someone is working on fixing that IIRC.

Ok. That might explain it then. :)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

