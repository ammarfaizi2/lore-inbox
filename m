Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVIXUDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVIXUDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVIXUDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 16:03:06 -0400
Received: from 2-1-3-15a.ens.sth.bostream.se ([82.182.31.214]:9689 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S1750708AbVIXUDF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 16:03:05 -0400
To: Peter Hicks <peter.hicks@poggs.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Velleman K8055 USB interface board
References: <4335A9E0.4010504@poggs.co.uk>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 24 Sep 2005 22:02:32 +0200
In-Reply-To: <4335A9E0.4010504@poggs.co.uk>
Message-ID: <m31x3etesn.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Hicks <peter.hicks@poggs.co.uk> writes:

> All,
> 
> Velleman make a USB interface board kit with analogue/digital inputs and
> outputs.
> 
> Linux kernel support is lacking, however the board is fairly simple.
> 
> Has anyone written a driver for this device, or would anyone be
> interested in writing one?  I've tried writing one myself, but a lack of
> knowledge on C and USB has stopped me.

There is no need for a kernel driver, you can find a libusb based
driver at:

    http://linuxk8055.free.fr/

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
