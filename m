Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbRFKVG1>; Mon, 11 Jun 2001 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263473AbRFKVGS>; Mon, 11 Jun 2001 17:06:18 -0400
Received: from flodhest.stud.ntnu.no ([129.241.56.24]:46840 "EHLO
	flodhest.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S263016AbRFKVGH>; Mon, 11 Jun 2001 17:06:07 -0400
Date: Mon, 11 Jun 2001 23:06:03 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: BCM5700, 1000 Mbps driver
Message-ID: <20010611230603.A10927@flodhest.stud.ntnu.no>
Reply-To: tlan@stud.ntnu.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know there's a driver for this floating around (I found mine through
search dell.com's pages), and I wondering if this is a driver that is in the
"testing phase" before it's going into the kernel, or if it's just a driver
provided by Dell?  The driver I found, was both pre-compiled as a module,
and given as source code. The only problem is that I can't get the
pre-compiled version to work on other things than std. redhat 7.x kernel
(ie. std. kernel when you install redhat, that is).  I can't get the source
code to compile either.

So, to sum up; 

* Are there anyone testing/maintaing this driver, trying to get it into the
  standard kernel source?
* If not, would it be rude for me to make it work with the latest kernels,
  and then submitt it? (I won't take credit for anything I haven't done, but
  since I haven't written the driver itself, I don't know what you guys think)



-- 
-Thomas
