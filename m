Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVJXSCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVJXSCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJXSCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:15 -0400
Received: from fmr23.intel.com ([143.183.121.15]:52696 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751208AbVJXSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:14 -0400
Message-Id: <20051021203818.753754000@araj-sfield>
Date: Fri, 21 Oct 2005 13:38:18 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org, linux@brodo.de
Cc: davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 0/4] dynamically create "cache" and "cpufreq" entries with CPU hotplug
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Resend... somehow first post never made out of here..]

This fixes the 2 entries in /sys/devices/system/cpu/cpuX to be created when 
CPU is onlined, and removed when they are offlined.

Andrew: please consider for next -mm.


Cheers,
ashok

