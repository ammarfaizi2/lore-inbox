Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTEKJdn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 05:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbTEKJdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 05:33:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30955 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261182AbTEKJdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 05:33:43 -0400
Date: Sun, 11 May 2003 11:46:20 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.69-dj1: bogus sound/isa/dt019x.c changes
Message-ID: <20030511094619.GB1107@fs.tum.de>
References: <20030510145653.GA26216@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510145653.GA26216@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the changes to sound/isa/dt019x.c (ALSA) in 2.5.69-dj1 are bogus, it
seems this is the reversion of a adaption to the PNP changes and it 
results in a compile error in -dj.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

