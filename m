Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272444AbTHNTAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275302AbTHNTAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:00:30 -0400
Received: from chromatix.demon.co.uk ([80.177.102.173]:187 "EHLO
	lithium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id S272444AbTHNTA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:00:29 -0400
Date: Thu, 14 Aug 2003 20:00:21 +0100
Subject: Re: agpgart failure on KT400
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Dave Jones <davej@redhat.com>
From: Jonathan Morton <chromi@chromatix.demon.co.uk>
In-Reply-To: <20030814184741.GA10901@redhat.com>
Message-Id: <8DB04511-CE89-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> agpgart: unable to determine aperture size.

> For 2.4, you're stuck. It needs AGP3 support. The KT400 stuff in
> 2.4 only works if you shove an AGP2.x gfx card in the slot.
> As soon as you put a 3.x capable card in there the chipset changes
> mode, and as there's no AGP3 support in 2.4 yet, you're pooched.

Damn.

Maybe I'd better try and see how well 2.6 works for me.  I'm guessing 
it's at least semistable, since the version number has changed.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@chromatix.demon.co.uk
website:  http://www.chromatix.uklinux.net/
tagline:  The key to knowledge is not to rely on people to teach you it.

