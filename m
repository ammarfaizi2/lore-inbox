Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbTH1Uhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTH1Uhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:37:39 -0400
Received: from smtp-3a.paradise.net.nz ([202.0.32.196]:55683 "EHLO
	smtp-3.paradise.net.nz") by vger.kernel.org with ESMTP
	id S264287AbTH1Uhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:37:37 -0400
Date: Fri, 29 Aug 2003 08:38:32 +1200
To: linux-kernel@vger.kernel.org
Subject: Complete system freeze running test3, should I investiage?
Message-ID: <20030828203832.GA10153@lakeland.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Corrin Lakeland <lakeland@lakeland.hopto.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm running fairly standard x86 hardware (VIA chipset, athlon, etc.)
The system was quite stable running 2.4, but since upgrading to 2.6 
I've had three complete system freezes.  Mouse and keyboard frozen, 
can't ping, nothing at all in the logs.  I was hoping to submit a bug 
report but alt-sysrq didn't work.  So, would people like me to 
investigate further (and if so, how?) or shall I just ignore it?

Corrin
