Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSIOTZf>; Sun, 15 Sep 2002 15:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSIOTZf>; Sun, 15 Sep 2002 15:25:35 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:29841 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318194AbSIOTZe>;
	Sun, 15 Sep 2002 15:25:34 -0400
Date: Sun, 15 Sep 2002 21:30:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       James Blackwell <jblack@linuxguru.net>, linux-kernel@vger.kernel.org,
       jonathan@buzzard.org.uk
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020915213009.A53847@ucw.cz>
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020915154248.GA3647@elf.ucw.cz>; from pavel@ucw.cz on Sun, Sep 15, 2002 at 05:42:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 05:42:48PM +0200, Pavel Machek wrote:
> Hi!
> 
> > You've just made the driver horribly racy on SMP or preempt
> > systems..
> 
> Well, as long as toshiba does not make SMP notebooks, we are safe ;-).

... or preempt. Which doesn't really depend on Toshiba.

-- 
Vojtech Pavlik
SuSE Labs
