Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272839AbTG3Sak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273219AbTG3Saj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:30:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54546
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272839AbTG3Saj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:30:39 -0400
Date: Wed, 30 Jul 2003 11:30:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730183033.GA970@matchmail.com>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730181006.GB21734@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 08:10:06PM +0200, Adrian Bunk wrote:
> On Wed, Jul 30, 2003 at 03:56:23PM +0200, Jan-Benedict Glaw wrote:
> >...
> > Please apply. Worst to say, even Debian seems to start using i486+
> > features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> > "lock" insn available)...
> 
> Shouldn't the 486 emulation in the latest 386 kernel images in Debian
> unstable take care of this?

What emulation?
