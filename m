Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUAOM6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 07:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUAOM6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 07:58:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64990 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266508AbUAOM6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 07:58:08 -0500
Date: Thu, 15 Jan 2004 13:58:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Frederick W. Kilner" <fkilner@alumni.cse.ucsc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 Build failure if .config:270 CONFIG_BLK_DEV_IDE=m
Message-ID: <20040115125802.GZ23383@fs.tum.de>
References: <Pine.GSO.4.05.10401132219200.8343-300000@alumni.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.05.10401132219200.8343-300000@alumni.cse.ucsc.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

thanks for your report.

Unfortunately, it's a known problem that modular IDE is currently broken 
in kernel 2.6 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

