Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWCYSyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCYSyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCYSyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:54:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33956 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932241AbWCYSyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:54:49 -0500
Date: Sat, 25 Mar 2006 19:54:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linda Walsh <lkml@tlinx.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Security downgrade? CONFIG_HOTPLUG required in 2.6.16? 
In-Reply-To: <44237D87.70300@tlinx.org>
Message-ID: <Pine.LNX.4.61.0603251954030.29793@yvahk01.tjqt.qr>
References: <44237D87.70300@tlinx.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I had this config'ed out in 2.6.15 for machine that didn't have
> any hotpluggable devices.  It is also configured with all the
> modules it needs and has kernel-module loading disabled.
>

Do you use swsusp?


Jan Engelhardt
-- 
