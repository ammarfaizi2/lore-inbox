Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTIZGqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 02:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTIZGqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 02:46:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:33671 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261968AbTIZGqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 02:46:02 -0400
Date: Fri, 26 Sep 2003 08:45:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nforce2 ethernet
Message-ID: <20030926064559.GA5906@ucw.cz>
References: <20030926054449.775e2cb5.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926054449.775e2cb5.spyro@f2s.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 05:44:49AM +0100, Ian Molton wrote:

> Anyone know how to get the Nforce2 ethernet working with a free driver?
> I dont want to use binary shite on this box if I can help it...
> 
> I heard it was similar to the 8111e ethernet but changing the PCI IDs
> didnt make it work (surprise surprise). It did seem to insmod and make
> an attempt to do something but the MAC address was all zeros.
> 
> anyone got further than this?

Well, I was suggesting it originaly, but now it's verified - it's not
similar to the 8111e. It seems to be a nVidia design.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
