Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWGaVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWGaVOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWGaVOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:14:45 -0400
Received: from mail.gmx.de ([213.165.64.21]:418 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750906AbWGaVOp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:14:45 -0400
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Mon, 31 Jul 2006 23:14:37 +0200
User-Agent: KMail/1.9.3
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
References: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net> <20060731192902.GS31121@lug-owl.de>
In-Reply-To: <20060731192902.GS31121@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607312314.37863.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 21:29, Jan-Benedict Glaw wrote:
>
> The point is that it's quite hard to really fuck up ext{2,3} with only
> some KB being written while it seems (due to the
> fragile^Wsophisticated on-disk data structures) that it's just easy to
> kill a reiser3 filesystem.
>

Well, I was once very 'luckily' and after a system crash (*) e2fsck put all 
files into lost+found. Sure, I never experienced this again, but I also never 
experienced something like this with reiserfs. So please, stop this kind of 
FUD against reiser3.6.
While filesystem speed is nice, it also would be great if reiser4.x would be 
very robust against any kind of hardware failures.

(*) The problem was a specific mainboard + video-card + driver combination. As 
soon as X started up, the system entirely crashed. I don't believe many bytes 
were written, but I also can't prove it.

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg

