Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUCYTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUCYTVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:21:23 -0500
Received: from fmr03.intel.com ([143.183.121.5]:60324 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263538AbUCYTVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:21:19 -0500
Message-Id: <200403251920.i2PJKwF25849@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Todd Poynor'" <tpoynor@mvista.com>
Cc: <linux-ia64@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "CPU Freq ML" <cpufreq@www.linux.org.uk>
Subject: RE: add lowpower_idle sysctl
Date: Thu, 25 Mar 2004 11:20:58 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQNPL2OgLWS3uEOTw+kbstXJU7ZfAFYRFAQ
In-Reply-To: <405A29EA.6000400@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Todd Poynor wrote on Thu, March 18, 2004 3:00 PM
> I'd vote for using Patrick Mochel's PM subsystem and use a standard
> set of identifiers that are mapped to a platform-specific idle behavior,
> in  much the same way as platform suspend modes are handled today.  For
> example, strings echoed to /sys/power/idle could be an interface.  If
> folks are amenable to this I'd be happy to supply a (generic) patch for it.

Just wondering what is the state of development for this new PM scheme?
I don't check LKML that frequently, sorry if I miss any posting on LKML.

- Ken


