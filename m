Return-Path: <linux-kernel-owner+w=401wt.eu-S1751441AbXAKTwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbXAKTwu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAKTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:52:50 -0500
Received: from twin.jikos.cz ([213.151.79.26]:58322 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbXAKTwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:52:49 -0500
X-Greylist: delayed 3381 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jan 2007 14:52:49 EST
Date: Thu, 11 Jan 2007 19:56:03 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Anssi Hannula <anssi.hannula@gmail.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] hid: series of patches for PantherLord USB/PS2 2in1
 Adapter support
In-Reply-To: <20070111145115.405679742@delta.onse.fi>
Message-ID: <Pine.LNX.4.64.0701111954470.16747@twin.jikos.cz>
References: <20070111145115.405679742@delta.onse.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Anssi Hannula wrote:

> These three patches fix PantherLord USB/PS2 2in1 Adapter support
> so that it appears as two input devices, and add force feedback
> support for it.

Hi Anssi,

looks fine to me. If neither Greg nor Dmitry (added to CC) have any 
objections, I will queue it in my tree for 2.6.21-rc1.

Thanks,

-- 
Jiri Kosina
SUSE Labs

