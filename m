Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTFQT0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTFQT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:26:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264896AbTFQT0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:26:17 -0400
Subject: [KEXEC][ANNOUNCE] kexec for 2.5.72 available
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>, fastboot@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1055878770.1203.9.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Jun 2003 12:39:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch set for kexec for 2.5.72 is now available. This patch set is
based upon the stable 2.5.{67,68,69,70,71} versions. 

This patch was tested to work (not counting a VESA framebuffer
initialization problem after kexec-ing a new kernel) on a dual-proc
P4-1.7GHz Xeon system.

More info here:
http://www.osdl.org/archive/andyp/bloom/Code/Linux/Kexec/index.html

Unified full kexec patch for 2.5.72 is here:
http://www.osdl.org/archive/andyp/kexec/2.5.72/kexec2-2.5.72-full.patch

Not that anyone cares, but a unified full patch for 2.5.71 is here:
http://www.osdl.org/archive/andyp/kexec/2.5.71/kexec2-2.5.71-full.patch

Unstable 2.5.69 kexec patches from Eric Biederman are available here:
http://www.xmission.com/~ebiederm/files/kexec/



