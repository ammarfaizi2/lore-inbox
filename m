Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTIUKEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 06:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTIUKEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 06:04:45 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:64139 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262366AbTIUKEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 06:04:44 -0400
Date: Sun, 21 Sep 2003 12:04:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030921100436.GA18409@ucw.cz>
References: <200309201633.22414.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309201633.22414.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 04:33:22PM -0400, Rob Landley wrote:
> I've mentioned my keyboard repeat problems before.  I grepped through the logs 
> and found a whole bunch of these type messages:
> 
> Aug 17 05:28:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
> on isa0060/serio0) pressed.
> Aug 19 09:06:51 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x8e, 
> on isa0060/serio0) pressed.
> Aug 22 04:33:36 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcd, 
> 
> (There's more, it just goes on and on...)
> 
> Any clues?  (Thinkpad iSeries...  1200, I think.)

What kernel version? Can you test with latest?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
