Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUGLAQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUGLAQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 20:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266677AbUGLAQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 20:16:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19929 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266678AbUGLAQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 20:16:11 -0400
Date: Mon, 12 Jul 2004 02:16:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@linux-mips.org, kwalker@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: 2.6: sound/oss/swarm_cs4297a.c still required?
Message-ID: <20040712001604.GH4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.6 (I've checked 2.6.7-mm7) sound/oss/swarm_cs4297a.c is no longer 
listed in sound/oss/Makefile. Was this accidential, or should this file 
be removed?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

