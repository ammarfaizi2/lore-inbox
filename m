Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWFCVNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWFCVNj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWFCVNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 17:13:39 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:51850 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030337AbWFCVNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 17:13:38 -0400
Message-ID: <4481FB80.40709@drzeus.cx>
Date: Sat, 03 Jun 2006 23:13:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matt Reimer <mattjreimer@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2GB MMC/SD cards
References: <447AFE7A.3070401@drzeus.cx>	 <20060603141548.GA31182@flint.arm.linux.org.uk> <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com>
In-Reply-To: <f383264b0606031140l2051a2d7p6a9b2890a6063aef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reimer wrote:
>
> I suspect that a lot of these readers are broken, assuming 512 byte
> blocks.
>

That's what I thought until I looked closer at the Sandisk specs. Until
we can see what the official specs say, we won't really know what the
correct behaviour is. The Nokia boys working on the 770 have a copy.
Perhaps someone here knows how to get in touch with one of them that can
have a look?

Rgds
Pierre

