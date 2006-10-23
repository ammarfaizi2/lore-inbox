Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWJWGIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWJWGIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWJWGIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:08:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41405 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751563AbWJWGIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:08:15 -0400
Date: Sun, 22 Oct 2006 23:07:49 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: nickpiggin@yahoo.com.au, dino@in.ibm.com, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061022230749.e31ff48f.pj@sgi.com>
In-Reply-To: <20061022224002.C2526@unix-os.sc.intel.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<20061020210422.GA29870@in.ibm.com>
	<20061022201824.267525c9.pj@sgi.com>
	<453C4E22.9000308@yahoo.com.au>
	<20061022225108.21716614.pj@sgi.com>
	<20061022224002.C2526@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh wrote:
> > From our internal perspective, it's all about getting the sched domain
> > partitions cut down to a reasonable size, for performance reasons.
> 
> we need consider resource partitioning too..  and this is where
> google interests are probably coming from?

I dropped a bit - what's 'resource partitioning' ?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
