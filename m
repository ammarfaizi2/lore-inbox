Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVDDECp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDDECp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 00:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDECo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 00:02:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:7399 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261576AbVDDECd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 00:02:33 -0400
Date: Sun, 3 Apr 2005 21:01:45 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Mark Lord <lkml@rtr.ca>
Cc: zlynx@acm.org, greg@kroah.com, floam@sh.nu, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-Id: <20050403210145.0d1c1eff.pj@engr.sgi.com>
In-Reply-To: <42507F2F.1050405@rtr.ca>
References: <1111886147.1495.3.camel@localhost>
	<490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	<20050327181221.GB14502@kroah.com>
	<1112058277.14563.4.camel@localhost>
	<20050329033350.GA6990@kroah.com>
	<1112069010.12853.52.camel@localhost>
	<42507F2F.1050405@rtr.ca>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark wrote:
> Probably all Linux binary drivers *are* compiled using GPL'd header files,
> and thus are themselves subject to the GPL.

I doubt that there is a consensus that simply compiling something with
a GPL header necessarily and always subjects it to the GPL.  See your lawyer.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
