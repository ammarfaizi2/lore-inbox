Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSKOP6e>; Fri, 15 Nov 2002 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266406AbSKOP6e>; Fri, 15 Nov 2002 10:58:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60547 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266407AbSKOP6c>; Fri, 15 Nov 2002 10:58:32 -0500
Date: Fri, 15 Nov 2002 07:44:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mailing-lists@digitaleric.net,
       Jon Tollefson <kniht@us.ibm.com>
cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <443345337.1037346264@[10.10.2.3]>
In-Reply-To: <1037373320.19987.23.camel@irongate.swansea.linux.org.uk>
References: <1037373320.19987.23.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2002-11-15 at 02:53, Eric Northup wrote:
>> Would this be an appropriate use of the "version" tag in Bugzilla?  Currently 
>> the only choice is "2.5", but if that were renamed to "2.5-linus", then the 
>> other heavily used patchsets could be monitored while making it easy for 
>> people who only want to see bugs in Linus' tree.
> 
> That works for me. Create a 2.5-ac product that is assigned to me. I can
> then reassign them all to DaveM as appropriate

Right - that makes sense ... I'll let Jon figure out the best way
to acheive this inside bugzilla - Eric's suggestion of version would
be nicer, but require some significant mods to bugzilla, I think.
Failing that, your suggestion of a new product-type thing would be
pretty easy to implement.

M.

