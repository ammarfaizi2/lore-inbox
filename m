Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJ3AjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTJ3AjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:39:19 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28123 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262015AbTJ3AjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:39:11 -0500
Date: Wed, 29 Oct 2003 16:37:20 -0800
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Greg KH <greg@kroah.com>
Cc: "Guo, Min" <min.guo@intel.com>, linux-raid@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net,
       Lars Marowsky-Bree <lmb@suse.de>,
       "Ling, Xiaofeng" <xiaofeng.ling@intel.com>,
       Mark Bellon <mbellon@mvista.com>, linux-kernel@vger.kernel.org,
       cgl_discussion@osdl.org, Steven Dake <sdake@mvista.com>
Subject: Re: [cgl_discussion] Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031030003720.GA6000@penguin.co.intel.com>
References: <3ACA40606221794F80A5670F0AF15F840215DC2F@pdsmsx403.ccr.corp.intel.com> <20031029190421.GA4173@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029190421.GA4173@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 11:04:21AM -0800, Greg KH wrote:
<huge snip>
> In the interest of full disclosure, Min is one of the SDE authors, and I
> am one of the udev authors.

man... I saw this thread and thought there is no way in hell I am jumping in
this bloody mess.  oh well...
 
...and I told Min to help out on usde. 

> 
> Min, maybe you can answer why Intel has spent effort on this project
> instead of offering to help udev, which has been public for a long time
> now?
> 

I have never believed that any one implementation of (in CGL speak) "persistent
device naming" would be palatable by everyone, and have no problem in donating
some resources toward udev.  

In the past we experimented with udev, and even did a little work on
sysfsutils (which I though udev was using, but looking at udev-005 I still
see the libsysfs directory.)

I see the the TODO list in udev-005.  Are all these items wide open, or have
people already spoken for some parts?  Maybe you have a couple of items you 
consider higher priority?

    --rustyl
