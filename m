Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRCAVGJ>; Thu, 1 Mar 2001 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCAVF7>; Thu, 1 Mar 2001 16:05:59 -0500
Received: from host217-32-147-231.hg.mdip.bt.net ([217.32.147.231]:20484 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130008AbRCAVFv>;
	Thu, 1 Mar 2001 16:05:51 -0500
Date: Thu, 1 Mar 2001 21:05:34 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Pavel Machek <pavel@suse.cz>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hashing and directories
In-Reply-To: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0103012103140.754-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Alexander Viro wrote:
> 	* userland issues (what, you thought that limits on the
> command size will go away?)

the space allowed for arguments is not a userland issue, it is a kernel
limit defined by MAX_ARG_PAGES in binfmts.h, so one could tweak it if one
wanted to without breaking any userland.

Regards,
Tigran


