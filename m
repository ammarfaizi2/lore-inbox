Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTGQTM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbTGQTM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:12:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:723 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267561AbTGQTM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:12:58 -0400
Date: Thu, 17 Jul 2003 21:27:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: liam.girdwood@wolfsonmicro.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2: ac97_plugin_wm97xx.c doesn't compile non-modular
Message-ID: <20030717192745.GH1407@fs.tum.de>
References: <20030717184046.GG1407@fs.tum.de> <200307171920.h6HJKvU18756@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307171920.h6HJKvU18756@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 03:20:57PM -0400, Alan Cox wrote:
> > ac97_plugin_wm97xx.c doesn't compile non-modular:
> 
> Missing linux/string.h perhaps ?

No, strtok was removed from 2.6.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

