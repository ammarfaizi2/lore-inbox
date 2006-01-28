Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWA1Ibc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWA1Ibc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 03:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWA1Ibb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 03:31:31 -0500
Received: from [217.157.19.70] ([217.157.19.70]:15575 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S1751354AbWA1Ibb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 03:31:31 -0500
Date: Sat, 28 Jan 2006 08:31:26 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Karim Yaghmour <karim@opersys.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43DB0343.1090808@opersys.com>
Message-ID: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006, Karim Yaghmour wrote:

> Just to make sure there is no confusion: note that both signed and
> unsigned kernels behave identically here. It's the user-space applications
> now that fail when attempting to access some piece of hardware. The
> classic case being a mmap'ed register window, therefore both the signed
> and unsigned kernel can map it to user-space (i.e. no modification in
> behavior for the GPLv3'ed kernel), but the applications' read/writes on
> said registers don't work on the non-signed kernel.

That would be a dubious circumvention. Remember that the GPLv3 is still a
draft - the wording can (and should probably) be improved to make it clear
that the system as a whole must behave identically if a modified version
of the GPL'ed software is used.

> Like I said in the LWN forum thread, I do believe things such as DRM
> are worth fighting for, but I really think the GPL is the wrong venue.

It's a good place to start putting pressure on the OEM's. If they can
choose between heavy DRM'ed and closed hardware, and pay millions in
license fees, or get the software they need for free in return for
dropping the restrictions, some are bound to choose the free route. This
is where the fight begins.

Thomas

