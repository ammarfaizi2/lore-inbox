Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUBBJ1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUBBJ1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:27:13 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22449 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265660AbUBBJ1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:27:12 -0500
Date: Mon, 2 Feb 2004 10:24:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: joshk@triplehelix.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202092436.GF548@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201163136.GF11391@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 08:31:37AM -0800, Joshua Kwan wrote:
> On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
> > I'm getting double clicks when I click only once.
> 
> I get these spuriously and i'm using only /dev/input/mice in my config
> flie.

Can yo send me the XF86Config file, dmesg, /proc/bus/input/devices, etc,
so that we can debug this?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
