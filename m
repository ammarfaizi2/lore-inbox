Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVJ2CbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVJ2CbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVJ2CbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:31:19 -0400
Received: from www.swissdisk.com ([216.144.233.50]:17589 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1751098AbVJ2CbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:31:18 -0400
Date: Fri, 28 Oct 2005 18:23:39 -0700
From: Ben Collins <bcollins@debian.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPARC64: Configuration offers keyboards that don't make sense
Message-ID: <20051029012339.GA11286@swissdisk.com>
References: <bcollins@debian.org> <20051028193228.GB10209@swissdisk.com> <200510290000.j9T00415021442@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510290000.j9T00415021442@inti.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> An Ultra 1 (yes, I know it is old and klunky, but I kind of like it...).
> That is why I did not configure USB or PCI (they just aren't available).
> Should that make a difference?

Nah, just make sure you have all the right sbus stuff enabled. Been awhile
since I did a kernel for an sbus sparc64 that wasn't headless, so I'm not
much help right now :)

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
