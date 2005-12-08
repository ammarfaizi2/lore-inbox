Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVLHIwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVLHIwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVLHIwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:52:53 -0500
Received: from main.gmane.org ([80.91.229.2]:15278 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750842AbVLHIwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:52:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dirk Steuwer <dirk@steuwer.de>
Subject: Re: free Driver proposal (tm)
Date: Thu, 8 Dec 2005 08:50:21 +0000 (UTC)
Message-ID: <loom.20051208T092818-441@post.gmane.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org> <loom.20051206T094816-40@post.gmane.org> <20051206104652.GB3354@favonius> <loom.20051206T173458-358@post.gmane.org> <20051207141720.GA533@kvack.org> <43979569.5090805@student.ltu.se> <20051208023816.GA7184@kvack.org> <4397B348.7070205@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.61.178.52 (Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.12) Gecko/20050919 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0 <at> student.ltu.se> writes:

> 
> Benjamin LaHaise wrote:
> 
> >On Thu, Dec 08, 2005 at 03:07:37AM +0100, Richard Knutsson wrote:
> >  
> >
> >>Why not something more of "Runs on Open Drivers", which also gives us a 
> >>chance to "teach" people why to use an open OS without the replies:
> >>"Windows is pretty" (actually, it was a guy who told me that)
> >>    
> >>

Yes, i was thinking purely about openDrivers. 
Lets do it this way:

- get all open operating system folks to join
- have an approval organisation, that everyone is happy with
- lets call it "free driver" support
- create apropriate Logos for each operating system i.e. "Penguin-Logo" 
with "free driver since kernel-a.b.c.d" or "BSD-Daemon-Logo" with "free driver
since a.b"
- the hardware version numer (usb-device id, pci-id)? will be held in a
database. 
If in doubt people can look it up there. In case future kernels will
drop support, it can be marked there as well. 
A yearly logo is too much
confusion, since hardware support for open drivers stays pretty long in 
the kernel. (Imagine you license in december - you only got a month...)
Maybe educate people that support for kernel 2.6.x.y series means a 
penguin logo on blue ground. 
If dramatic changes to the kernel are introduced, which all
drivers affect call the kernel 2.8.x.y an educate people about a new linux 
in town and create a penguin logo on yellow ground

- hardware vendors pay someone, or provide source code themselves 
to be reviewed by apropriate kernel folks/bsd board...

- small licence fee and endless advertising possiblilities pay for 
organisation folks and hosting. 
Keeping up database records could help kernel developers.
There could be a log file attached to each device stating the 
current affairs about support in varying OSs


Dirk

