Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275921AbSIUPTA>; Sat, 21 Sep 2002 11:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275922AbSIUPTA>; Sat, 21 Sep 2002 11:19:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:52204 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275921AbSIUPS7>; Sat, 21 Sep 2002 11:18:59 -0400
Date: Sat, 21 Sep 2002 08:21:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Greg KH <greg@kroah.com>, "Rhoads, Rob" <rob.rhoads@intel.com>,
       linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net,
       cgl_discussion@lists.osdl.org
Subject: Re: my review of the Device Driver Hardening Design Spec
Message-ID: <593580073.1032596512@[10.10.2.3]>
In-Reply-To: <20020921053452.GB26254@kroah.com>
References: <20020921053452.GB26254@kroah.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do I think can be salvaged?  Diagnostics are a good idea, and I
> think they fit into the driver model in 2.5 pretty well.  A lot of
> kernel janitoring work could be done by the CG team to clean up, and
> harden (by applying the things in section 2) the existing kernel
> drivers.  That effort alone would go a long way in helping the stability
> of Linux, and also introduce the CG developers into the kernel community
> as active, helping developers.  It would allow the CG developers to
> learn from the existing developers, as we must be doing something right
> for Linux to be working as well as it does :)

People with fault injection hardware are also extremely helpful 
(assuming they do something useful with it). That's not something most 
of the community would have access to, but the CG-type people probably 
do. A couple of people who spent their full time kicking the hell out
of Sequent's fibrechannel system made a massive difference to it's
quality and reliabilty. 

That's definitely something this project could help by doing ... 
whatever people feel about the some of more theoretical aspects to 
their work being discussed, I think few would object to some real-world 
help from people tracking down and fixing existing bugs, especially in
the error handling.

M.

