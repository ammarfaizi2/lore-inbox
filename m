Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJTLck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJTLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:32:40 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:55537 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262540AbTJTLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:32:39 -0400
Subject: Module problems with NVIDIA and 2.6.0-test8?
From: Chris Anderson <chris@simoniac.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066649707.22658.4.camel@kuso>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 07:35:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently built test8 and also the NVIDIA driver using the patches from
minion.de. The compile had no errors and I can load the module without
errors as well (aside from the "NVIDIA taints the kernel" message).
However, even with the module loaded, X says it cannot initialize it and
acts exactly as if the module was never there. Not much is left to work
with in the logs so frankly I'm stumped. The system works fine with the
"nv" driver and I had the driver working in test1. Has anyone else
experienced a problem like this?

Log: www.simoniac.com/~chris/XFree86.0.log

Config: www.simoniac.com/~chris/XF86Config-4

-Chris

