Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTKCLBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 06:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKCLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 06:01:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28546
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262033AbTKCLBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 06:01:43 -0500
Date: Mon, 3 Nov 2003 12:01:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
Message-ID: <20031103110129.GF1772@x30.random>
References: <3FA62DD4.1020202@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA62DD4.1020202@portrix.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 11:28:36AM +0100, Jan Dittmer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I'm experiencing skips in games like q3demo and enemy territory on a
> dual xeon p4. That means, if I'm walking around, about every 2-3 seconds
> I'm skipping a bit of the way. It seems that the clock is running too
> slow and the games are trying to catch up every x seconds with the
> system time.
> System is running 2.6.0-test9-mm1. This effect does not show with
> 2.4.23pre6aa3, though there are only two processors displayed. Is this

btw, to make it even better for a desktop multimedia usage like yours,
you can also pass 'desktop' to the 2.4.23pre6aa3 kernel. I'd like to
hear how 'desktop' affects your usage in 2.4.23pre6aa3.

thanks.
