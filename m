Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTBDADk>; Mon, 3 Feb 2003 19:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBDADj>; Mon, 3 Feb 2003 19:03:39 -0500
Received: from dp.samba.org ([66.70.73.150]:46247 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267048AbTBDADj>;
	Mon, 3 Feb 2003 19:03:39 -0500
Date: Tue, 4 Feb 2003 11:11:25 +1100
From: Anton Blanchard <anton@samba.org>
To: jt@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 32bit emulation of wireless ioctls
Message-ID: <20030204001125.GD25023@krispykreme>
References: <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de> <20030203214325.GA28330@bougret.hpl.hp.com> <20030203224619.GA6405@wotan.suse.de> <20030203231740.GA29267@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203231740.GA29267@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	<Puzzled of why you would *not* want a 64 bit userland>

Because I regularly move my userland between my 32bit G4 laptop and 64bit
p690 :) On most architectures, 64bit just adds unnecessary bloat.

Anton
