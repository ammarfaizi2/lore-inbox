Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287649AbRLaVe0>; Mon, 31 Dec 2001 16:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287651AbRLaVeQ>; Mon, 31 Dec 2001 16:34:16 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:55233 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287649AbRLaVeB>;
	Mon, 31 Dec 2001 16:34:01 -0500
Date: Mon, 31 Dec 2001 22:33:53 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Micah Anderson <micah@riseup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20 crashing every other day
Message-ID: <20011231223353.A23894@fafner.intra.cogenit.fr>
In-Reply-To: <20011231115217.P19151@riseup.net> <20011231213024.A22942@fafner.intra.cogenit.fr> <20011231131136.T19151@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011231131136.T19151@riseup.net>; from micah@riseup.net on Mon, Dec 31, 2001 at 01:11:36PM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micah Anderson <micah@riseup.net> :
[...]
> unfortunately I dont know enough about the kernels to determine how to
> "backpatch" this, anyone have a 2.2 patch?!

Until you find one, you can "fix" the bit with setpci (beware: you may still 
have fscked your memory by the time you issue the adequate setpci command).

-- 
Ueimor - sleep 36000
