Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270543AbTGZR4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270575AbTGZR4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:56:24 -0400
Received: from dialpool-210-214-81-45.maa.sify.net ([210.214.81.45]:27781 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270543AbTGZR4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:56:23 -0400
Date: Sat, 26 Jul 2003 23:42:33 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: cpu-freq P4 no sysfs interface
Message-ID: <20030726181233.GA2894@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.0-test1

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_X86_P4_CLOCKMOD=y

But there seems to be no cpu/ in /sysfs/class
