Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSIOR5m>; Sun, 15 Sep 2002 13:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSIOR5m>; Sun, 15 Sep 2002 13:57:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:5248 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318145AbSIOR5l>;
	Sun, 15 Sep 2002 13:57:41 -0400
Date: Sun, 15 Sep 2002 17:42:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>,
       James Blackwell <jblack@linuxguru.net>, linux-kernel@vger.kernel.org,
       jonathan@buzzard.org.uk
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020915154248.GA3647@elf.ucw.cz>
References: <20020909115956.GA23290@comet> <20020911112938.A25726@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911112938.A25726@infradead.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You've just made the driver horribly racy on SMP or preempt
> systems..

Well, as long as toshiba does not make SMP notebooks, we are safe ;-).

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
