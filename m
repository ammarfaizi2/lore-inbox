Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTIJKx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbTIJKx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:53:27 -0400
Received: from www.mail15.com ([194.186.131.96]:61703 "EHLO www.mail15.com")
	by vger.kernel.org with ESMTP id S261814AbTIJKx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:53:26 -0400
Date: Wed, 10 Sep 2003 14:52:46 +0400 (MSD)
Message-Id: <200309101052.h8AAqk86011501@www.mail15.com>
From: Muthukumar <kmuthukumar@mail15.com>
To: j_patiani@plasa.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: 
X-Proxy-IP: [203.129.254.138]
X-Originating-IP: [172.16.1.46]
Subject: Re: kernel panic linux-2.4.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hai all ..,

 Regarding to the kernel panic on linux-2.4.22,pls enable the file 
system support of MINIX in the make menuconfig and also enable the 
ROM DISK support in the menuconfig.

The error is occuring because of the inavailability of support to 
the MINIX support ,in my view.

In the menuconfig use filesystem support to select or in config 
file check for this.


REgards
Mvthv
