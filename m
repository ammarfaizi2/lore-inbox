Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUDGUBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUDGUBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:01:14 -0400
Received: from bender.bawue.de ([193.7.176.20]:11476 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S264196AbUDGUBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:01:11 -0400
Date: Wed, 7 Apr 2004 20:36:32 +0200
From: Joerg Sommrey <jo@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cannot rmmod amd76x_pm on 2.6.5-mm1
Message-ID: <20040407183632.GA3234@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when rmmod'ing amd76x_pm on 2.6.5-mm1 the system freezes and gets a hard
reboot from my watchdog. On 2.6.5 there's no problem unloading this
module.  It's not a big problem as there is not really a reason to
unload this piece of code.  However, something is wrong with it...

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-04-07 20:24 /home/jo/.signature
