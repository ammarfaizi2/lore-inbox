Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSG3VaI>; Tue, 30 Jul 2002 17:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSG3VaH>; Tue, 30 Jul 2002 17:30:07 -0400
Received: from 12-225-96-71.client.attbi.com ([12.225.96.71]:3201 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S316589AbSG3V2y>;
	Tue, 30 Jul 2002 17:28:54 -0400
Date: Tue, 30 Jul 2002 14:32:34 -0700
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Subject: IRQTUNE and irq priority
Message-ID: <20020730143234.A17111@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an OLD tool called "irqtune"

         http://www.best.com/~cae/irqtune

by Craig Estey, which says about itself:

   "irqtune changes the IRQ priority of devices to allow devices
    that require high priority and fast service 
    (e.g. serial ports, modems) to have it...."

I'm told it still works even with recent kernels, but could 
someone comment on how good an idea it is and if there are
better and newer ways to do this with recent kernels.


Thanks,

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================
