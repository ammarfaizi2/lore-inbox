Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267172AbUBSAPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbUBSAPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:15:44 -0500
Received: from mx.eastlink.ca ([24.222.0.20]:8254 "EHLO mx.eastlink.ca")
	by vger.kernel.org with ESMTP id S267172AbUBSAPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:15:42 -0500
Date: Wed, 18 Feb 2004 20:06:47 -0400 (AST)
From: Steve Bromwich <kernel@fop.ns.ca>
Subject: Re: harddisk or kernel problem?
In-reply-to: <Pine.GSO.4.21.0402181039520.8134-100000@dirac.phys.uwm.edu>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.58.0402182002180.11305@brain.fop.ns.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.GSO.4.21.0402181039520.8134-100000@dirac.phys.uwm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, Bruce Allen wrote:

> > 194 Temperature_Celsius     0x0022   100   050   000    Old_age   Always
> > -       48 (Lifetime Min/Max 14/65)
> >
> > If I'm reading this correctly, you've been running the drive when it's
> > extremely cold and extremely hot (Min/Max 14/65, I'm guessing that's
> > either Fahrenheit or a raw unconverted reading from the thermistor).
>
> Neither.  Fujitsu uses Celsuis: 14, 48, and 65 are all in Celsuis.

Good grief... I'm not surprised the drive's dying, then! I've seen drives
lock up around 35C, I'm quite impressed the drive is still chugging along
(to some extent, at least) at 48C - and a max of 65C? Looking at a few of
Fujitsu's pages (eg,
http://www.fujitsu.ca/products/mobile_hdd/mht_ah/physical_specs.html),
ambient operating temperature is 5C to 55C - perhaps that's the cause of
the drive dying?

Just out of curiosity, Nico, what're you doing with these drives that
they're running so hot?

Cheers, Steve
