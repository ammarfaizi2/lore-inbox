Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbUAKKeB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 05:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUAKKeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 05:34:01 -0500
Received: from AGrenoble-101-1-1-238.w193-251.abo.wanadoo.fr ([193.251.23.238]:33676
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S265838AbUAKKd7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 05:33:59 -0500
Subject: Re: Laptops & CPU frequency
From: Xavier Bestel <xavier.bestel@free.fr>
To: Robert Love <rml@ximian.com>
Cc: jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073816858.6189.186.camel@nomade>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1073817226.6189.189.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 11:33:47 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim 11/01/2004 à 11:27, Xavier Bestel a écrit :

> > The MHz value in /proc/cpuinfo should be updated as the CPU speed
> > changes - that is, it is not calculated just at boot, but it is updated
> > as the speed actually changes.
> 
> 2.6.0 doesn't do that on my laptop. Moreover, if I ever boot on battery,
> when switching to AC power, lots of things fail (mouse is jerky, pcmcia
> doesn't work ...)

I forgot one particularly annoying too: time is going twice too fast.

	Xav

