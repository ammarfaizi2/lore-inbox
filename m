Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbTHOQOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHOQNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269646AbTHOQJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:59 -0400
Date: Fri, 15 Aug 2003 15:52:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815135248.GA7315@win.tue.nl>
References: <16188.27810.50931.158166@gargle.gargle.HOWL> <20030815094604.B2784@pclin040.win.tue.nl> <20030815105802.GA14836@ucw.cz> <16188.54799.675256.608570@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16188.54799.675256.608570@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 10:46:07PM +1000, Neil Brown wrote:

> It seems to work (though some of the keys actually generate 'down'
> events for both the down and up transitions, so it seems that the key
> is pressed twice.

Maybe it really is as you say. But your description sounds fishy.
It would be nice to know what really happens.
(And it would be nice to know which scancodes are involved.)



