Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRBEPJA>; Mon, 5 Feb 2001 10:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130529AbRBEPIu>; Mon, 5 Feb 2001 10:08:50 -0500
Received: from host217-32-121-81.hg.mdip.bt.net ([217.32.121.81]:6918 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130012AbRBEPIh>;
	Mon, 5 Feb 2001 10:08:37 -0500
Date: Mon, 5 Feb 2001 15:11:25 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.2-pre1] rootfs boot parameter
In-Reply-To: <20010205160452.A9464@almesberger.net>
Message-ID: <Pine.LNX.4.21.0102051510120.1452-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, since so many people ask for it to be called "rootfstype=", I will do
so and resend the patch.

Any other comments? I think on the last round I have incorporated all the
comments (except the "rootfs" -> "rootfstype" one)...

Tigran


On Mon, 5 Feb 2001, Werner Almesberger wrote:

> Tigran Aivazian wrote:
> > This patch adds "rootfs" boot parameter which selects the filesystem type
> > for the root filesystem.
> 
> Could you please make this rootfstype= or fstype= or maybe
> root=<device>[,<type>] or such ? Calling it "rootfs" is just asking
> for trouble ...
> 
> - Werner
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
