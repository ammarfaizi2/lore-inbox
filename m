Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbSKOQng>; Fri, 15 Nov 2002 11:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSKOQng>; Fri, 15 Nov 2002 11:43:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43653 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266438AbSKOQmx>;
	Fri, 15 Nov 2002 11:42:53 -0500
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
From: Jon Tollefson <kniht@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mailing-lists@digitaleric.net,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <443345337.1037346264@[10.10.2.3]>
References: <1037373320.19987.23.camel@irongate.swansea.linux.org.uk> 
	<443345337.1037346264@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Nov 2002 10:49:36 -0600
Message-Id: <1037378977.6872.113.camel@skynet.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-15 at 09:44, Martin J. Bligh wrote:
> > On Fri, 2002-11-15 at 02:53, Eric Northup wrote:
> >> Would this be an appropriate use of the "version" tag in Bugzilla?  Currently 
> >> the only choice is "2.5", but if that were renamed to "2.5-linus", then the 
> >> other heavily used patchsets could be monitored while making it easy for 
> >> people who only want to see bugs in Linus' tree.
> > 
> > That works for me. Create a 2.5-ac product that is assigned to me. I can
> > then reassign them all to DaveM as appropriate
> 
> Right - that makes sense ... I'll let Jon figure out the best way
> to acheive this inside bugzilla - Eric's suggestion of version would
> be nicer, but require some significant mods to bugzilla, I think.
> Failing that, your suggestion of a new product-type thing would be
> pretty easy to implement.
> 
> M.
> 
> 

What if we create a top level category called Patches(or something) and
have a components under that for each tree, patch set.  So anything
thats not from Linus' tree could be put into one of these components.
The natural owner for each of these components would be the maintainer
of the named tree/patch.  Perhaps that is what you are suggesting above
and I have misread it?

Jon


