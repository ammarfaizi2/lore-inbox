Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272879AbTG3MjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272881AbTG3MjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:39:23 -0400
Received: from home.wiggy.net ([213.84.101.140]:33456 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S272879AbTG3MjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:39:20 -0400
Date: Wed, 30 Jul 2003 14:39:18 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystemever
Message-ID: <20030730123918.GB26515@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030729151701.GA6795@bodmin.doc.ic.ac.uk> <20030729180005.GD2601@openzaurus.ucw.cz> <1059565549.27394.9.camel@vimes.crl.hpl.hp.com> <001101c35693$8e97cc40$0a00a8c0@toumi> <20030730122749.GA31982@bodmin.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730122749.GA31982@bodmin.doc.ic.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Philip Graham Willoughby wrote:
> The LED devices I'm using are nothing like any of the devices in the
> input subsystem at all -- they don't generate events _ever_ for
> instance.  /dev/input/event## for a pure LED device would be rather
> boring.

Neither does the PC speaker but it still uses the input subsystem. 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

