Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273185AbTG3SKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273186AbTG3SKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:10:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6397 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S273185AbTG3SKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:10:13 -0400
Date: Wed, 30 Jul 2003 20:10:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730181006.GB21734@fs.tum.de>
References: <20030730135623.GA1873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730135623.GA1873@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 03:56:23PM +0200, Jan-Benedict Glaw wrote:
>...
> Please apply. Worst to say, even Debian seems to start using i486+
> features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> "lock" insn available)...

Shouldn't the 486 emulation in the latest 386 kernel images in Debian
unstable take care of this?

> MfG, JBG
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

