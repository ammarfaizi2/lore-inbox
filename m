Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSHYN3p>; Sun, 25 Aug 2002 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSHYN3p>; Sun, 25 Aug 2002 09:29:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:24480 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317363AbSHYN3o>;
	Sun, 25 Aug 2002 09:29:44 -0400
Date: Sun, 25 Aug 2002 15:33:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: kris <C.Devalquenaire@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.5 Problem ne.c driver
Message-ID: <20020825153351.A26878@ucw.cz>
References: <3D68C32C.AD7D9414@wanadoo.fr> <3D68CD62.C3E59923@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D68CD62.C3E59923@wanadoo.fr>; from C.Devalquenaire@wanadoo.fr on Sun, Aug 25, 2002 at 02:28:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 02:28:18PM +0200, kris wrote:

> kris wrote:
> > 
> > I have 2 ne2000 isa cards (10Mbps for each) and with this versions of
> > kernel the bandwith is divided by 2. So 2*5Mbps = 10Mbps instead of
> > 2*10Mbps=20Mbps.
> > I try to fix the pbm.
> 
> perhaps a bug exists on the dispatcher when 2 identical cards exist.
> Anyone have 2 identical cards for test ?

The ISA bus is a cause of the speed limit.

-- 
Vojtech Pavlik
SuSE Labs
