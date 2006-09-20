Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWITUH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWITUH5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWITUH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:07:57 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:778 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1750711AbWITUH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:07:56 -0400
Subject: Re: [patch 8/8] stacktrace filtering for fault-injection
	capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20060920133927.GA4030@miraclelinux.com>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102033.462112306@localhost.localdomain>
	 <1158645471.2419.13.camel@localhost.localdomain>
	 <20060919090945.GE24271@miraclelinux.com>
	 <1158687327.2509.13.camel@localhost.localdomain>
	 <20060920133927.GA4030@miraclelinux.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 13:02:09 -0700
Message-Id: <1158782530.2509.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 21:39 +0800, Akinobu Mita wrote:
> Perhaps you can move UNWIND_INFO, STACK_UNWIND, and DEBUG_FS
> entries ealier in the list. It improves improve appearance for
> other DEBUG_KERNEL dependent config options like (DEBUG_VM,
> FRAME_POINTER, ...).

Okay, I will prepare such a janitorial patch.

