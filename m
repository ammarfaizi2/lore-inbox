Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268473AbTGIRoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268483AbTGIRoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:44:04 -0400
Received: from pdbn-d9bb87fd.pool.mediaWays.net ([217.187.135.253]:6923 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S268473AbTGIRoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:44:01 -0400
Date: Wed, 9 Jul 2003 19:58:27 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org, mru@users.sourceforge.net
Subject: Re: Promise SATA 150 TX2 plus
Message-ID: <20030709175827.GA412@citd.de>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ff01c34642$5512d7f0$401a71c3@izidor>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 04:51:13PM +0200, Milan Roubal wrote:
> So other question - is there SATA controler that
> is working in linux multiple controlers (4 cards)
> and is for better bus than standart PCI? Like PCI-X or
> PCI 66 MHz like promise is?

Highpoint RocketRAID 1540 or 1542.
(www.highpoint-tech.com)

OK, it's not native SATA but a PATA with converters, but at least for me
that a none-issue.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

