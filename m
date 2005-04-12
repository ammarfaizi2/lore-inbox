Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVDLGEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVDLGEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVDLGDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 02:03:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7085 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262074AbVDLGC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 02:02:28 -0400
Date: Mon, 11 Apr 2005 23:00:15 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: lkml@chrisli.org, torvalds@osdl.org, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-Id: <20050411230015.7142f649.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0504112205190.16541@qynat.qvtvafvgr.pbz>
References: <20050409200709.GC3451@pasky.ji.cz>
	<Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<7vhdifcbmo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org>
	<20050410115055.2a6c26e8.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org>
	<20050410190331.GG13853@64m.dyndns.org>
	<Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
	<20050410195354.GH13853@64m.dyndns.org>
	<Pine.LNX.4.58.0504101611370.1267@ppc970.osdl.org>
	<20050410212850.GA23960@64m.dyndns.org>
	<Pine.LNX.4.62.0504112205190.16541@qynat.qvtvafvgr.pbz>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David wrote:
> and version control your entire system

Yeah - that works.  That's how I back up my system.  Not
git actually, but a similar sort of store (no compression,
a line oriented ascii 'index' file).

See my post on "Kernel SCM saga..", Sat, 9 Apr 2005 08:15:53 -0700,
Message-Id: <20050409081553.744bbb55.pj@engr.sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
