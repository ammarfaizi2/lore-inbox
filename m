Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTGGUh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGGUh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:37:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24573 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264447AbTGGUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:37:52 -0400
Date: Mon, 7 Jul 2003 22:52:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Steven Cole <elenstev@mesatop.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre3-ac1
Message-ID: <20030707205217.GO753@fs.tum.de>
References: <200307071634.h67GYZo06861@devserv.devel.redhat.com> <20030707170047.GC13102@louise.pinerecords.com> <1057600778.13991.57.camel@spc9.esa.lanl.gov> <20030707191342.GE13102@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707191342.GE13102@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 09:13:42PM +0200, Tomas Szepe wrote:
> > [elenstev@mesatop.com]
> > 
> > From the -not-a-real-fix- department, and only for the terminally
> > impatient, this gets 2.4.22-pre3-ac1 up and running on SMP.
> 
> This might actually be a real fix, as the conditions are in place
> because of a piece of code that apparently hasn't been merged.
> Alan?

It was merged in 2.4.21-ac4, it seems the changes to 
arch/i386/kernel/mpparse.c got lost at the update of -ac to -pre3.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

