Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVDNAaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDNAaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVDNAaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:30:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9587
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261257AbVDNAaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:30:08 -0400
Date: Thu, 14 Apr 2005 02:31:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc64: improve g5 sound headphone mute
Message-ID: <20050414003113.GX1521@opteron.random>
References: <jell7nu6yk.fsf@sykes.suse.de> <1113344225.21548.108.camel@gaston> <jey8bnk4lj.fsf@sykes.suse.de> <1113345561.5387.114.camel@gaston> <jed5szk3gh.fsf@sykes.suse.de> <1113347296.5388.121.camel@gaston> <je8y3nk117.fsf@sykes.suse.de> <1113350355.5387.129.camel@gaston> <jefyxvruip.fsf@sykes.suse.de> <1113391382.5463.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113391382.5463.20.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 09:23:02PM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> This patch fixes a couple more issues with the management of the GPIOs
> dealing with headphone and line out mute on the G5. It should fix the
> remaining problems of people not getting any sound out of the headphone
> jack.

It works great here with all patches applied, thanks!
