Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTFKJ1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTFKJ1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:27:30 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:6362 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264257AbTFKJ13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:27:29 -0400
Date: Wed, 11 Jun 2003 10:41:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Gregor Essers <gregor.essers@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 and AGP 8x Support
Message-ID: <20030611094103.GD14706@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Gregor Essers <gregor.essers@web.de>, linux-kernel@vger.kernel.org
References: <002b01c32fb6$beb6cbf0$3c02a8c0@saint1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002b01c32fb6$beb6cbf0$3c02a8c0@saint1>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 03:14:02AM +0200, Gregor Essers wrote:
 > In wich Kerneltree will this implented ?
 > 2.4.x or 2.5.x ?

2.5
I've not had the time to do a 2.4 backport. Several other folks
have tried, though as the 2.5 code is still constantly moving,
they tend to fall behind.

 > Ati-Drivers will not install or Run on 2.5.70 (its clear ;) )
 > and 2.4.20 and 2.4.21-pre7

Sadly, there are no fully open drivers for any AGP x8 cards still.
I'm still hoping this will change over time.

		Dave

