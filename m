Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVBVGkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVBVGkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVBVGkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:40:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:12010 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262217AbVBVGkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:40:15 -0500
Message-ID: <421AD4E4.9050701@sgi.com>
Date: Tue, 22 Feb 2005 00:44:52 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Paul Jackson <pj@sgi.com>, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42199EE8.9090101@sgi.com> <20050221121010.GC17667@wotan.suse.de>
In-Reply-To: <20050221121010.GC17667@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Oops.  It's late.  The pargraph below in my previous note confused
cpus and nodes.  It should have read as follows:

Let's suppose that nodes 0-1 of a 64 node [was: CPU] system have graphics
pipes.  To keep it simple, we will assume that there are 2 cpus
per node like an Altix [128 CPUS in this system]. Let's suppose that jobs
arrive as follows:
. . .

Sorry about that.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
