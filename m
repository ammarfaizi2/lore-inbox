Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSIOWWM>; Sun, 15 Sep 2002 18:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSIOWWM>; Sun, 15 Sep 2002 18:22:12 -0400
Received: from ns.suse.de ([213.95.15.193]:20749 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318270AbSIOWWL>;
	Sun, 15 Sep 2002 18:22:11 -0400
Date: Mon, 16 Sep 2002 00:27:07 +0200
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: James Blackwell <jblack@linuxguru.net>, linux-kernel@vger.kernel.org,
       hch@infradead.org, jonathan@buzzard.org.uk
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020916002707.D6528@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@ucw.cz>, James Blackwell <jblack@linuxguru.net>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	jonathan@buzzard.org.uk
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org> <20020915154248.GA3647@elf.ucw.cz> <20020915213009.A53847@ucw.cz> <20020915195328.GA60517@comet> <20020915200202.GA15744@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020915200202.GA15744@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Sun, Sep 15, 2002 at 10:02:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 10:02:02PM +0200, Pavel Machek wrote:

 > It would be nice to make it preempt/smp safe, through. [SMP notebooks
 > are not so unreasonable; think p4 hyperthreading].

Current P4 notebooks aren't using xeon's to the best
of my knowledge, though as such technology becomes more
commonplace, it's not unviable for the future maybe.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
