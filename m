Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUCMRHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUCMRHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:07:10 -0500
Received: from oliv.bezeqint.net ([192.115.104.12]:27029 "EHLO
	oliv.bezeqint.net") by vger.kernel.org with ESMTP id S263131AbUCMRG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:06:57 -0500
Date: Thu, 11 Mar 2004 16:17:03 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: lkml <linux-kernel@vger.kernel.org>
Subject: finding out the value of HZ from userspace
Message-ID: <20040311141703.GE3053@luna.mooo.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to find out what the kernel's notion of HZ is from user
space?
It seem to change from system to system and between 2.4 (100 on i386)
to 2.6 (1000 on i386).
