Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWDOTbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWDOTbg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWDOTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:31:36 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:27815 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751271AbWDOTbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:31:35 -0400
Date: Sat, 15 Apr 2006 21:31:34 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kir Kolyshkin <kir@openvz.org>, Kirill Korotaev <dev@openvz.org>,
       Sam Vilain <sam@vilain.net>, devel@openvz.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060415193134.GB19258@MAIL.13thfloor.at>
Mail-Followup-To: Cedric Le Goater <clg@fr.ibm.com>,
	Kir Kolyshkin <kir@openvz.org>, Kirill Korotaev <dev@openvz.org>,
	Sam Vilain <sam@vilain.net>, devel@openvz.org,
	linux-kernel@vger.kernel.org
References: <20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru> <1143668273.9969.19.camel@localhost.localdomain> <443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at> <443DF523.3060906@openvz.org> <20060413134239.GA6663@MAIL.13thfloor.at> <443EC399.2040307@fr.ibm.com> <443ED5F4.1030604@openvz.org> <443F7485.50301@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443F7485.50301@fr.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 12:08:05PM +0200, Cedric Le Goater wrote:
> Bonjour !
> 
> Kir Kolyshkin wrote:
> 
> > You made my day, I am really happy to hear that! Such testing and
> > benchmarking should be done by an independent third party, and
> > IBM fits that requirement just fine. It all makes much sense for
> > everybody who's involved.
> >
> > If it will be opened (not just results, but also the processes and
> > tools), and all the projects will be able to contribute and help,
> > that would be just great. We do a lot of testing in-house, and will
> > be happy to contribute to such an independent testing/benchmarking
> > project.
>
> What we have in mind is something like http://test.kernel.org/ for
> each patch set. I guess we will start humbly at the beginning :)
>
> Initially, the idea was to test the patch series we've been sending on
> lkml. But as we've been running tests on existing solutions, openvz,
> vserver, and our own prototype, we thought that extending to all was
> interesting and fair.

would be really great if you could extend that to something
like the PLM where folks (like linux-vserver and openvz) can
test their patches against mainline kernels in a fairly
automated way ...

I guess that would be some initial work, but could improve
many other patches (not only those related to virtualization)

best,
Herbert

> The goal is to promote lightweight containers in the linux kernel, so
> this needs to be open.
> 
> > Speaking of live migration, we in OpenVZ plan to release our
> > implementation as soon as next week.
>
> We've been working on that topic for a long time, we are very
> interested in seeing what you've acheived ! Migration tests is also an
> interesting topic we could add with time to the containers tests.
> 
> thanks,
> 
> C.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
