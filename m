Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWDNKIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWDNKIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 06:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbWDNKIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 06:08:11 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:28926 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S965129AbWDNKIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 06:08:10 -0400
Message-ID: <443F7485.50301@fr.ibm.com>
Date: Fri, 14 Apr 2006 12:08:05 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kir Kolyshkin <kir@openvz.org>
CC: Kirill Korotaev <dev@openvz.org>, Sam Vilain <sam@vilain.net>,
       devel@openvz.org, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143583179.6325.10.camel@localhost.localdomain>	<4429B789.4030209@sacred.ru>	<1143588501.6325.75.camel@localhost.localdomain>	<442A4FAA.4010505@openvz.org>	<20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru>	<1143668273.9969.19.camel@localhost.localdomain>	<443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at>	<443DF523.3060906@openvz.org> <20060413134239.GA6663@MAIL.13thfloor.at> <443EC399.2040307@fr.ibm.com> <443ED5F4.1030604@openvz.org>
In-Reply-To: <443ED5F4.1030604@openvz.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bonjour !

Kir Kolyshkin wrote:

> You made my day, I am really happy to hear that! Such testing and
> benchmarking should be done by an independent third party, and IBM fits
> that requirement just fine. It all makes much sense for everybody who's
> involved.
> 
> If it will be opened (not just results, but also the processes and
> tools), and all the projects will be able to contribute and help, that
> would be just great. We do a lot of testing in-house, and will be happy
> to contribute to such an independent testing/benchmarking project.

What we have in mind is something like http://test.kernel.org/ for each
patch set. I guess we will start humbly at the beginning :)

Initially, the idea was to test the patch series we've been sending on
lkml. But as we've been running tests on existing solutions, openvz,
vserver, and our own prototype, we thought that extending to all was
interesting and fair.

The goal is to promote lightweight containers in the linux kernel, so this
needs to be open.

> Speaking of live migration, we in OpenVZ plan to release our
> implementation as soon as next week.

We've been working on that topic for a long time, we are very interested in
seeing what you've acheived ! Migration tests is also an interesting topic
we could add with time to the containers tests.

thanks,

C.
