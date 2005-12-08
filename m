Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVLHN1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVLHN1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVLHN1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:27:13 -0500
Received: from main.gmane.org ([80.91.229.2]:50055 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751135AbVLHN1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:27:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dirk Steuwer <dirk@steuwer.de>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 8 Dec 2005 13:23:11 +0000 (UTC)
Message-ID: <loom.20051208T140839-587@post.gmane.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <1133857767.2858.25.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com> <Pine.LNX.4.58.0512071041420.17648@shark.he.net> <1133981708.2869.54.camel@laptopd505.fenrus.org> <20051207201612.GV28539@opteron.random> <1133986742.2869.65.camel@laptopd505.fenrus.org> <20051207204029.GW28539@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.61.178.52 (Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.12) Gecko/20050919 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea <at> cpushare.com> writes:

> 
> On Wed, Dec 07, 2005 at 09:19:02PM +0100, Arjan van de Ven wrote:
> > the problem with this is that with wiki's you get a sliding scope wrt
> > criteria; I mean, many people will say nvidia graphics work great with
> > linux... and the wiki will represent that ;(
> 
> then the wiki will be closed. But it worth a try. Of course the topic
> will explain it's a list of hardware supported by open source (GPL
> compatible) drivers.
> 
> Like wiki.kernel.org/OpenSourceKernelDrivers
> 


I think this could be of value, although i have my problems with a wiki solution.
As pointed out, there is no structure in the wiki itself, the advantages are 
just that quick'n'easy editing is possible and everyone can start topics.

For a hardwaredatabase i like to see a structure. Kernel developers are 
required to enter the support into the database, when submitting the driver.
Ongoing status will be logged there as well. Status and devices can only be 
entered by kernel developers.
The interface could have a mixed structure - fixed fields in the header 
(device ID, status, kernel version,..) 
and a wiki style body for free editing of additional info. 
Below each device there could be a open comment forum, allowing user/tester
to leave info.

this whole thing could then serve as a starting point for this diskussion:
http://thread.gmane.org/gmane.linux.kernel/355950

Where an logo is awarded for full device support with free driver, which
hardware vendors can stick on their boxes. Customers therefore know that
this device is "Plug and Play" :-) no driver installation hassle.
This is what linux should be known for, not like the current situation..

regards,
Dirk

