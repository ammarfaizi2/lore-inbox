Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289604AbSAOTQ5>; Tue, 15 Jan 2002 14:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290251AbSAOTQs>; Tue, 15 Jan 2002 14:16:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2053 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290255AbSAOTQd>; Tue, 15 Jan 2002 14:16:33 -0500
Date: Tue, 15 Jan 2002 19:16:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
Message-ID: <20020115191625.F1822@flint.arm.linux.org.uk>
In-Reply-To: <3C4401CD.3040408@debian.org> <20020115105733.B994@flint.arm.linux.org.uk> <3C442395.8010500@debian.org> <20020115183432.GC27059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115183432.GC27059@kroah.com>; from greg@kroah.com on Tue, Jan 15, 2002 at 10:34:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 10:34:32AM -0800, Greg KH wrote:
> Russell, when /sbin/hotplug is part of the initramfs in 2.5, the driver
> will automatically be loaded for your new card, IF you have all the
> different modules already built.  You will not need autoconfigure, just
> a good vendor kernel :)

Chuckle.  I believe you still need to pass the module parameters, even
though it can detect the chip.  I have no idea why, and I no longer have
the ISDN card within my administrative control.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

