Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSIEB1X>; Wed, 4 Sep 2002 21:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSIEB1W>; Wed, 4 Sep 2002 21:27:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:34040 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316582AbSIEB1V>; Wed, 4 Sep 2002 21:27:21 -0400
Date: Wed, 4 Sep 2002 21:31:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20020904213156.A6367@redhat.com>
References: <825516963@toto.iv> <15734.37217.686498.162782@wombat.chubb.wattle.id.au> <20020904200424.O1394@redhat.com> <E17mkfj-000627-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17mkfj-000627-00@starship>; from phillips@arcor.de on Thu, Sep 05, 2002 at 02:38:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 02:38:58AM +0200, Daniel Phillips wrote:
> The thing is, I don't see why we should be building castles and cathedrals
> around printk.  Just cast to the wider value, if you get it wrong you have
> lost exactly what?  Are people feeding the output of dmesg into scripts
> that their systems depend upon?  If so, we need to let evolution do its
> work.

Why do it the broken way when you can do it a non-broken way?  Arguing in 
favour of having it broken by design isn't something I really understand.  
Anyways, I'll refrain from posting any further comments on this thread.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
