Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTIMHZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 03:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTIMHZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 03:25:18 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:8834
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S262068AbTIMHZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 03:25:15 -0400
Message-Id: <200309130725.h8D7PE6d019675@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
 aborting."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Sep 2003 01:25:14 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to build SCSI support into 2.6.0-test5, 
I configure SCSI, but
whether I configure NO driver at all
or configure the aic7xxx driver
when I get to the 
    make install
I constantly get the error message  
    No module aic7xxx found for kernel 2.6.0-test5, aborting.

Surely SOMEONE has built this kernel with SCSI support, 
so why is it giving me this trouble.

I can probably build w/o ANY SCSI support at all, but that wouldnt be
useful, so I havent tried...
-- 
                                        Reg.Clemens
                                        reg@dwf.com


