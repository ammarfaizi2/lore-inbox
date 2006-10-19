Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWJSGau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWJSGau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161336AbWJSGat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:30:49 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17336 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161335AbWJSGas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:30:48 -0400
Date: Wed, 18 Oct 2006 23:30:37 -0700
From: Paul Jackson <pj@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-Id: <20061018233037.046ebb05.pj@sgi.com>
In-Reply-To: <20061018105035.B26521@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com>
	<20061017114306.A19690@unix-os.sc.intel.com>
	<20061017121823.e6f695aa.pj@sgi.com>
	<20061017190144.A19901@unix-os.sc.intel.com>
	<20061018000512.1d13aabd.pj@sgi.com>
	<20061018105035.B26521@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh, responding to pj:
> > It was to show that even the existing cpu_exclusive
> > flag lets one create sched domains configurations that might not be
> > what one wanted.
> 
> I agree with your point. Lets take this out of discussion for now.

Excellent.

Rather than taking this point out of discussion, lets extend this
agreement, to remove the existing cpu_exclusive flag's side affect of
creating sched domain configurations.

Patches coming shortly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
