Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbTGTQvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbTGTQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:51:47 -0400
Received: from H143.C231.tor.velocet.net ([216.138.231.143]:22405 "EHLO
	mjfrazer.org") by vger.kernel.org with ESMTP id S267504AbTGTQvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:51:02 -0400
Date: Sun, 20 Jul 2003 13:06:02 -0400
From: Mark Frazer <mark@mjfrazer.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1 panics on MCE with athlon
Message-ID: <20030720130602.A439@mjfrazer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Bender: Want me to smack the corpse around a little?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turning off MCE fixes things.  Leaving MCE on was fine under 2.4.21.

A boot log, cpuinfo and config are at
http://mjfrazer.org/~mjfrazer/linux/2.6-mce/

-mark
-- 
Like most of life's problems, this one can be solved with bending. - Bender
