Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUIQEUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUIQEUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUIQEUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:20:03 -0400
Received: from [12.177.129.25] ([12.177.129.25]:7620 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268396AbUIQETN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:19:13 -0400
Message-Id: <200409170523.i8H5NZ2J005424@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Pete Zaitcev <zaitcev@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ub vs. ubd 
In-Reply-To: Your message of "Thu, 16 Sep 2004 10:34:54 PDT."
             <20040916103454.46936a28@lembas.zaitcev.lan> 
References: <1340.1095332981@www10.gmx.net> <20040916084118.2441c38a@lembas.zaitcev.lan> <200409161753.i8GHrM2J003175@ccure.user-mode-linux.org>  <20040916103454.46936a28@lembas.zaitcev.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:23:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zaitcev@redhat.com said:
> Can you send me your /proc/partitions from a guest with a few UBDs
> configured? 

usermode:~# more /proc/partitions 
major minor  #blocks  name

  98     0    1049600 ubda
  98    16    1049600 ubdb
  98    32     204801 ubdc

				Jeff

