Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVBNNUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVBNNUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 08:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBNNUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 08:20:18 -0500
Received: from monster.coolgoose.com ([204.101.246.228]:40681 "EHLO
	monster.coolgoose.com") by vger.kernel.org with ESMTP
	id S261426AbVBNNUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 08:20:15 -0500
Message-Id: <1108387210.143301299@as03.coolgoose.com>
From: "Nikhil Bhargava" <nikhilbhargav_nsit@coolgoose.com>
To: linux-kernel@vger.kernel.org
Subject: options to debug drivers in form of loadable modules
Date: Mon, 14 Feb 2005 18:50:10 +0550
X-Originating-IP: [64.175.181.86]
X-Abuse-to: abuse@coolgoose.com
X-Mailer: mcDesktop v1.0.3; Copyright (c) 2001-2003 Multiboard Communications Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

I am looking for ways to debug those device drivers that have been written as loadable modules 
and loaded on fly and not complied with kernel. Using printks do help and looing at debug 
messages also help but at time of crach during development, its very difficult to find the exact 
location of crash. 

Any pointers or suggestions


Thanks,

nikhil bhargava
