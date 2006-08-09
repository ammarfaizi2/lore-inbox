Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWHICRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWHICRO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWHICRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:17:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36793 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751244AbWHICRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:17:13 -0400
Date: Tue, 8 Aug 2006 22:17:08 -0400
From: john stultz <johnstul@us.ibm.com>
To: ak@suse.de
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Message-Id: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
Subject: [RFC][PATCH 0/6] x86_64: Generic timekeeping for x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andi,
	Just wanted to send this by as a first pass on the x86_64 
generic timekeeping conversion. If you have the time, a quick review 
and comments would be greatly appreciated. 
	
	As this is the first run after breaking up the larger patch I 
was carrying around, there might be a few rough spots. I've made sure 
the patchset compiles at each stage, but I've not boot tested each step 
(all together they run fine, though).

If anyone else is interested here, my full timekeeping tree can be 
found here: http://sr71.net/~jstultz/tod/

New in the current C5 release:
o ia64 and sparc64 conversions by Peter Keilty!

Let me know if you have any thoughts or comments!

thanks again!
-john
