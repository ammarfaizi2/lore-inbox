Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbTGHU6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267642AbTGHU6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:58:16 -0400
Received: from outbound04.telus.net ([199.185.220.223]:8950 "EHLO
	priv-edtnes15-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S267638AbTGHU6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:58:16 -0400
Subject: SBP2 and IEEE1394 in 2.5.74
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057698811.6911.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Jul 2003 15:13:31 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have at long last had reasonable success building 2.5.74 (I configured
ACPI out, and along with it went scheduling_while_atomic).  The only
issue now is firewire, specifically modules SBP2 and IEEE1394.  I looked
at the source and found it to be amazingly small (not many files and
none larger that about 30 bytes).  Is there any timeline when these will
be joining the kernel?  I would switch over to using 2.5.X tomorrow if
these could be completed/working.  Is there a 2.4.X retrograde patch
that could be applied to make these work before the complete 2.5.X
version is completed?  Thanks,

Bob

-- 
Bob Gill <gillb4@telusplanet.net>

