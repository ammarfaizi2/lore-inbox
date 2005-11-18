Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVKRQZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVKRQZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbVKRQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:25:29 -0500
Received: from kanga.kvack.org ([66.96.29.28]:42673 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932348AbVKRQZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:25:29 -0500
Date: Fri, 18 Nov 2005 11:23:00 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: linux-kernel@vger.kernel.org
Subject: intel8x0 sound of silence on dell system
Message-ID: <20051118162300.GA22092@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On trying out head on my workstation, it seems that no sound comes out.  
The module is getting loaded and the interrupts line for the 'Intel ICH5' 
is increasing.  The RHEL 4 kernel is known to work on this machine.  The 
only output from the driver is below.  Any ideas?

		-ben

intel8x0_measure_ac97_clock: measured 51314 usecs
intel8x0: clocking to 48000
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.
