Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271828AbTHDQGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271849AbTHDQGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:06:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:3303 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271828AbTHDQF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:05:59 -0400
Message-Id: <200308041607.h74G7fT20187@es175.pdx.osdl.net>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm3 osdl-aim-7 regression 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Aug 2003 09:07:41 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see 2.6.0-test2-mm4 is already in our queue, so this may be
Old News. ( serves me right for taking a weekend off )
Performance of -mm3 falls off on the 4-cpu machines. 

2-cpu ssytems
Kernel 			JPM 
2.6.0-test2-mm3		1313.53
linux-2.6.0-test2	1320.68 (0.54 % +)

4-cpu systems
2.6.0-test2-mm3		4824.96
linux-2.6.0-test2	5381.20 ( 11.53 % + )

Full details at
http://developer.osdl.org/cliffw/reaim/index.html
code at 
bk://developer.osdl.org/osdl-aim-7

cliffw


