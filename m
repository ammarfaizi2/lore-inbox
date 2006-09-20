Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWITXbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWITXbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWITXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:31:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11156 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750709AbWITXbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:31:31 -0400
Date: Wed, 20 Sep 2006 16:31:22 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: lhms-devel@lists.sourceforge.net
cc: Rohit Seth <rohitseth@google.com>, Paul Jackson <pj@sgi.com>,
       ckrm-tech@lists.sourceforge.net, devel@openvz.org, npiggin@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158794808.7207.14.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201629220.1859@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com> 
 <1158773208.8574.53.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com> 
 <1158775678.8574.81.camel@galaxy.corp.google.com>  <20060920155815.33b03991.pj@sgi.com>
 <1158794808.7207.14.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> Absolutely.  Since these containers are not (hard) partitioning the
> memory in any way so it is easy to change the limits (effectively
> reducing and increasing the memory limits for tasks belonging to
> containers).  As you said, memory hot-un-plug is important and it is
> non-trivial amount of work.

Maybe the hotplug guys want to contribute to the discussion?
