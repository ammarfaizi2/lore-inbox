Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTFGUOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTFGUOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:14:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:14750 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263503AbTFGUO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:14:29 -0400
Date: Sat, 7 Jun 2003 22:27:59 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607222759.A4689@ucw.cz>
References: <20030607063424.GA12616@averell> <20030607115908.K31364@ucw.cz> <20030607184426.GA3744@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030607184426.GA3744@averell>; from ak@muc.de on Sat, Jun 07, 2003 at 08:44:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 08:44:26PM +0200, Andi Kleen wrote:

> On Sat, Jun 07, 2003 at 11:59:08AM +0200, Vojtech Pavlik wrote:
> > I'm quite OK with this, but I'd like it to give a pointer where to
> > disable EMBEDDED, and also give a possibility to do it other than
> > editing .config manually.
> 
> Hmm? You don't need to edit .config manually to disable EMBEDDED. It is 
> a standard visible top level option in "General options"

Oops, sorry, I did not remember that one.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
