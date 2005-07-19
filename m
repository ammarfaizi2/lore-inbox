Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVGSTZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVGSTZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVGSTZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:25:48 -0400
Received: from lnscu5.lns.cornell.edu ([128.84.44.111]:52744 "EHLO
	lnscu5.lns.cornell.edu") by vger.kernel.org with ESMTP
	id S261712AbVGSTZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:25:45 -0400
Date: Tue, 19 Jul 2005 15:21:33 -0400 (EDT)
From: Hubert Schwarthoff <hubert@mail.lns.cornell.edu>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Dual-core with kernel 2.4 (Red Hat EL 3)
Message-ID: <Pine.OSF.4.21.0507191519340.12129-100000@lns181.lns.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo, Linux folks!
(first post here)
I am trying to find out whether I can start using dual-core cpus with a 
2.4 kernel (Red Hat EL 3).
Three questions below - please answer if you have any insight.
 - The first update to EL 4 announced "support" for dual core cpus both
   from AMD and Intel, but doesn't say what that support means. I would
   think with the right BIOS, the OS might distribute all tasks among
   all cores right out of the box, as long as you don't need any special
   parallel computing capabilities.
   Or will the kernel just not recognize the second core?
 - The most recent update to EL 3 (which is what I am using) does not
   say anything about dual-core. Does that mean there is no chance it
   will run on a dual-core chip, because it has kernel 2.4?
 - My application is multi process server type stuff. I'd like to use
   Intel dual chip boards. Are there any Intel dual chip dual-core
   solutions you can buy? I haven't found one yet.
 Cheers
 Hubert Schwarthoff

