Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVHAT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVHAT1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVHAT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 15:27:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39555 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261177AbVHAT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 15:27:34 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: David Weinehall <tao@acc.umu.se>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <42EE4B4A.80602@andrew.cmu.edu>
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>
	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>
	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>
	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>
	 <1122852234.13000.27.camel@mindpipe>
	 <20050801074447.GJ9841@khan.acc.umu.se>  <42EE4B4A.80602@andrew.cmu.edu>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 15:27:32 -0400
Message-Id: <1122924452.15825.48.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 12:18 -0400, James Bruce wrote:
> Yes, Lee needs to chill a bit.  I'll hopefully explain our position 
> calmly enough below.

I am a bit frustrated because when I first objected to 250HZ as the
default, I was told to come up with some numbers.  Now we have the
numbers, and they overwhelmingly show that 250HZ WILL hurt interactivity
and WILL NOT save anyone any power in real life.  But now the 250HZ
people have changed their position to "yes, we KNOW we're screwing over
multimedia users for the sake of laptop users, and we DON'T CARE about
your numbers."

Lee

