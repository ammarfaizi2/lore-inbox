Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWILTwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWILTwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWILTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:52:42 -0400
Received: from us.cactii.net ([66.160.141.151]:7949 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1030392AbWILTwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:52:41 -0400
Date: Tue, 12 Sep 2006 21:52:16 +0200
From: Ben B <kernel@bb.cactii.net>
To: linux-kernel@vger.kernel.org
Subject: speedstep-centrino broken..?
Message-ID: <20060912195216.GA20723@cactii.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My HP notebook decided that its BIOS upgrade would break
speedstep-centrino, and trying to load the module gives me a "no such
device" error. This is with various combinations of kernel config
relating to cpufreq. Also tried acpi-cpufreq with the same error.

I suspect that the new bios is broken, but perhaps it's correct and the
linux driver is missing something?

I've put relevent info at this URL (the list server thought it was
spam):

http://nl.cactii.net/~bb/cpufreq-broke.txt

Cheers,
Ben

(also sent to davej@codemonkey.org.uk)
