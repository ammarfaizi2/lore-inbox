Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVCUUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVCUUlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVCUUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:38:15 -0500
Received: from web50205.mail.yahoo.com ([206.190.38.46]:15697 "HELO
	web50205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261878AbVCUUeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:34:14 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=V2hBUq7+jCrOD2JgEHdBmzW17WtA4W55WOnuRLA6gpFyuEUnwjbzCUqBYEQoaRcHaLhgQIb7UjlJNdmf1axdoPVAzDM/s5YHdp7rze+Ty0Ca9LRDes2O8cySD65cHeG7MLvHAtAQIvrbMe2nGPheMaVgHSrDwpKnbTPWcrIy1Tk=  ;
Message-ID: <20050321203408.74684.qmail@web50205.mail.yahoo.com>
Date: Mon, 21 Mar 2005 12:34:07 -0800 (PST)
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajesh,

--- Rajesh Shah <rajesh.shah@intel.com> wrote:
> On Sat, Mar 19, 2005 at 03:50:16PM +0200, Paul Ionescu wrote:
> > 
> > Does this mean that when it will be ported for i386, I will be able to
> > really use my Docking Station ?
> 
> No. The current patches only trigger when a _root_ bridge is
> hot-added, not a PCI to PCI bridge (which is what the docking 
> station is). The code to support p2p bridge hotplug will benefit
> from these patches but more code is needed to support that.
> 

Thanks for the info.
Is p2p hotplug in your roadmap (for i386) ?
Can you please give me an example of a root bridge ?

Thanks,
Paul



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
