Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTLDWDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTLDWDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:03:16 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:18305
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263619AbTLDWDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:03:14 -0500
Date: Thu, 4 Dec 2003 17:02:13 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: "Russell \"Elik\" Rademacher" <elik@webspires.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading Xeons Support - 2.4 Kernel - Patch Anyone?
In-Reply-To: <5410840093.20031204145242@webspires.com>
Message-ID: <Pine.LNX.4.58.0312041701540.27578@montezuma.fsmlabs.com>
References: <5410840093.20031204145242@webspires.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, Russell "Elik" Rademacher wrote:

> Hello folks,
>
>     I been wondering what the position on the developers on the hyperthreading on 2.4.x series kernels? I know it is fully supported in 2.6.x series, but it used to be supported on 2.4.20 and below and now it disappeared on 2.4.21 to 2.4.23 as far reporting the hyperthreaded Xeons processors.  If there is a patch for this that enables it and support it, I would appreciate it so I can get this back on the kernel and have it running.
>
>     Lot of my clients are complaining about it saying they spents $$$$ for Xeons processors and linux 2.4.x don't support it anymore or don't report the number of processors properly anymore.  I for one want to shut them up. :)

Turn on ACPI

