Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVFJQok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVFJQok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVFJQo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:44:27 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:49595 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262566AbVFJQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:44:24 -0400
Subject: computer/kernel lockup
From: Yuri Shirman <shirman@lanl.gov>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jun 2005 10:44:22 -0600
Message-Id: <1118421862.6161.0.camel@gaugino.lanl.gov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have intermittent kernel lockups (happensabout once a week).
It happens with all kernels I have on the machine  (fedora
kernels 2.6.9... through 2.6.11). Once it happens I can only reboot 
the computer using Alt-SysRq key.

I happened to be in the terminal window during one of the lockups, and
kernel gave out some info, but most of it scrolled off the screen
(nothing went to /var/log/messages). Similarly, trying to get info with
Alt-SysRq does not help because most of the info is off the screen.
I do not have an easy way to redirect this output somewhere through the
serial
port.

I would appreciate any help in either capturing the output of Alt-SysRq
or more generally diagnosing the problem. I will recompile the kernel
if needed for diagnostics.

Please cc the answer to shirman@lanl.gov

Thanks,
Yuri Shirman
-- 
Yuri Shirman <shirman@lanl.gov>
