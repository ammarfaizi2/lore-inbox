Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283828AbRK3Xk7>; Fri, 30 Nov 2001 18:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283833AbRK3Xku>; Fri, 30 Nov 2001 18:40:50 -0500
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:38660
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id <S283831AbRK3Xki>; Fri, 30 Nov 2001 18:40:38 -0500
Date: Fri, 30 Nov 2001 15:44:57 -0800
From: Neil Schemenauer <nas@python.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre2, IO, and interactive performance
Message-ID: <20011130154457.A5886@glacier.arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When testing with "dd if=/dev/zero of=zero", 2.4.17-pre2 feels much
smoother than 2.4.16.  My hardware:

    AMD K7 1400 Mhz
    512 MB RAM
    VIA vt82c686b (rev 40) IDE UDMA100 controller
    20 GB IDE disk (IBM?, /proc/ide/had/model says IC35L020AVER07-0)

Cheers,

  Neil
