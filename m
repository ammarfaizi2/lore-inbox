Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVLAXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVLAXRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLAXRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:17:39 -0500
Received: from mail.arava.co.il ([212.29.226.3]:10963 "HELO arava.co.il")
	by vger.kernel.org with SMTP id S932561AbVLAXRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:17:38 -0500
Date: Fri, 2 Dec 2005 01:17:38 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
X-X-Sender: matan@matan.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Franck <vagabon.xyz@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
In-Reply-To: <20051130165546.GD1053@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0512020115410.4828@matan.home>
References: <cda58cb80511300821y72f3354av@mail.gmail.com>
 <20051130162327.GC1053@flint.arm.linux.org.uk> <cda58cb80511300845j18c81ce6p@mail.gmail.com>
 <20051130165546.GD1053@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, Russell King wrote:

> So until someone says "I want to use this on such and such arch" I
> think it's better to keep it dependent on those we know are likely
> to support it.

I use DM9000 on SH-4.


-- 
Matan Ziv-Av.                         matan@svgalib.org

