Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265387AbUFBXmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbUFBXmT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbUFBXmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:42:19 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:26497 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S261862AbUFBXlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:41:49 -0400
Date: Thu, 3 Jun 2004 01:43:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Benoit Plessis <benoit@plessis.info>, linux-kernel@vger.kernel.org
Subject: Re: Input system and keycodes > 256
Message-ID: <20040602234313.GD1366@ucw.cz>
References: <1082938686.21842.50.camel@osiris.localnet.fr> <20040428234841.GA4068@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428234841.GA4068@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:48:41AM +0200, Andries Brouwer wrote:
> On Mon, Apr 26, 2004 at 02:18:07AM +0200, Benoit Plessis wrote:
> 
> > When grabbing with 'showkey -s' nothing appear
> > When grabbing with 'showkey' i got keycodes like '0x00 0x82 0xd0 | 0x80
> > 0x82 0xd0' (i got same keycodes when pressing mouse buttons except those
> > are in 0x82 0x90 -> 0x82 0x97 range)
> 
> What version of showkey are you using?

A normal mode. This is 2.6 extended medium raw mode I suppose.

-- 
