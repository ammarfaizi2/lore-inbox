Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274995AbTHFKIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHFKIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:08:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6597 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S274995AbTHFKIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:08:20 -0400
Date: Wed, 6 Aug 2003 12:08:15 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <d.nuetzel@wearabrain.de>
Cc: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Message-ID: <20030806100815.GH16091@fs.tum.de>
References: <200308060621.06216.d.nuetzel@wearabrain.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308060621.06216.d.nuetzel@wearabrain.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Aug 06, 2003 at 06:21:06AM +0200, Dieter Nützel wrote:
> Hello,

Hi Dieter,

> I had it running very well on my dual Athlon MP 1900+ for several months 
> before. Latest Kernel was 2.4.22-pre5+ACPI patch.
> 
> Any changes?
> I changed lm_sensors from 2.7.0 (?) to 2.8.0
> 
> System:
> dual Athlon MP 1900+
> MSI K7D Master-L
> 
> 2.4.22-rc1
> acpi-20030730-2.4.22-pre8.diff
> preempt-kernel-rml-2.4.21-1.patch
>...

does an unpatched 2.4.22-rc1 work?

If yes, please check which of the two patches causes the problem.

> Thanks.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

