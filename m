Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269877AbUJMWQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269877AbUJMWQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 18:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269880AbUJMWQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 18:16:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:25001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269877AbUJMWQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 18:16:46 -0400
Subject: Announcing Binary Compatibility/Testing
From: "Timothy D. Witham" <wookie@osdl.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Development Lab, Inc.
Date: Wed, 13 Oct 2004 15:16:53 -0700
Message-Id: <1097705813.6077.52.camel@wookie-zd7>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing Binary Compatibility/Testing 

  In talking to end users, distributions, OSS developers and 
large scale ISV's one issue kept popping up.  And that is 
the fact that binaries keep breaking.  

  This is a real problem for large end users deploying Linux
in that they like to be able to run/roll forward the same version
of an application for 5 or so years.  They can do this with their
legacy operating systems and we need to be able to do this 
with Linux.

One of the big problems is that these ISV's release and test
on a cycle that is measured in calendar quarters and of course
the OSS cycle is measured in days.   The idea is to move
testing of these binary applications upstream to match
the OSS development cycle.  For this purpose I've started
a mailing list to discuss how to accomplish this.   I've
got slides for anybody who is interested. (PDF.)

http://lists.osdl.org/mailman/listinfo/binary_sig

http://groups.osdl.org/sig  (Follow binary testing for slides)

Let the flaming start. :-)

Tim


-- 
Timothy D. Witham - Chief Technology Officer - wookie@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton OR, 97005
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

