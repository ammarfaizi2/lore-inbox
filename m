Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUCZPxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbUCZPxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:53:20 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:64130 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S264068AbUCZPxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:53:16 -0500
Date: Fri, 26 Mar 2004 16:53:15 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040326155315.GA8724@boogie.lpds.sztaki.hu>
References: <20040325225423.GT9248@cheney.cx> <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com> <20040326131629.GB26910@zombie.inka.de> <40643BFA.1000302@stesmi.com> <20040326142917.GB30664@zombie.inka.de> <40644071.9090900@stesmi.com> <20040326145506.GA31759@zombie.inka.de> <40644629.9090602@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40644629.9090602@stesmi.com>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 04:03:05PM +0100, Stefan Smietanowski wrote:

> To draw a parallel between a WAV or PNG file (a well-known standard)
> to a firmware for a specific card (a closed standard) is thin.
> 
> Even though I can modify a PNG or WAV file using a hex editor it
> is _NOT_ preferred form, and neither is modifying the firmware
> using a hex editor, neither to me nor to the people doing the cards.

You are mixing the preferred form with the editor. If you do not have
the GIMP (or other similar tool) then you _do_ have to edit the PNG file
with a hex editor, but the binary PNG file is still the preferred form
for editing.

If a firmware author uses a proprietary tool that reads the binary
firmware image, let's the user edit it, and again writes out a binary
image, then that binary image _is_ the preferred form simply because no
other form exists. And it is completely irrelevant if the proprietaty
editor represented the firmware image on the screen in a high-level
language or as assembler code or as graphics or as anything else.

So unless you can _prove_ that the author of the firmware image does
indeed use some other form as the source of the image (guessing is not
enough), this whole thread is meaningless.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
