Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUALXIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUALXIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:08:50 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5079 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262603AbUALXIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:08:47 -0500
Date: Tue, 13 Jan 2004 00:08:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [0/3] three i386 patches
Message-ID: <20040112230839.GP9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

following this mail, I'll send the following three patches that have 
accumulated in my better i386 CPU selection patch (but don't depend on 
it):

[1/3] gcc 2.95 supports -march=k6 (no need for check_gcc)
[2/3] added Pentium M and Pentium-4 M options
[3/3] AMD Elan is a different subarch

Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

