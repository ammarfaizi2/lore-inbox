Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTEFCgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTEFCgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:36:01 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40975
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262270AbTEFCgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:36:00 -0400
Date: Mon, 5 May 2003 19:48:19 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 - unresolved
Message-ID: <20030506024819.GC8350@matchmail.com>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <3EA48145.70A5589@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA48145.70A5589@eyal.emu.id.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 09:39:49AM +1000, Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> > 
> > Here goes the first candidate for 2.4.21.
> > 
> > Please test it extensively.
> 

Lets add a couple more:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1-rmap15g/kernel/drivers/char/drm/sis.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1-rmap15g/kernel/drivers/i2c/scx200_i2c.o
