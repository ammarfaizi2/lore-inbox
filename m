Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUHBWZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUHBWZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUHBWZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:25:34 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:52493 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S264260AbUHBWZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:25:31 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [SSI-devel] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Date: Mon, 2 Aug 2004 15:25:27 -0700
Message-ID: <3689AF909D816446BA505D21F1461AE4C750F0@cacexc04.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SSI-devel] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
Thread-Index: AcR4wD9rzMNvj7DCSy64IXWXzPon0AAHxQdA
From: "Walker, Bruce J" <bruce.walker@hp.com>
To: "Erich Focht" <efocht@gmx.net>, "K V, Aneesh Kumar" <aneesh.kumar@hp.com>
Cc: <ssic-linux-devel@lists.sourceforge.net>, "Andi Kleen" <ak@muc.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-cluster@redhat.com>
X-OriginalArrivalTime: 02 Aug 2004 22:25:27.0501 (UTC) FILETIME=[9CAF97D0:01C478DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I indicated earlier, we are going to redo the hooks for 2.6 and
submit them in a more managable way.  I expect that to take several
months.

Bruce Walker
Project manager for OpenSSI.


> -----Original Message-----
> From: ssic-linux-devel-admin@lists.sourceforge.net 
> [mailto:ssic-linux-devel-admin@lists.sourceforge.net] On 
> Behalf Of Erich Focht
> Sent: Monday, August 02, 2004 6:51 AM
> To: K V, Aneesh Kumar
> Cc: ssic-linux-devel@lists.sourceforge.net; Andi Kleen; Linux 
> Kernel Mailing List; linux-cluster@redhat.com
> Subject: Re: [SSI-devel] Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
> 
> 
> On Monday 02 August 2004 08:30, Aneesh Kumar K.V wrote:
> > > [....] Congratulations. But I was a bit disappointed that there
> > > wasn't a tarball with the kernel patches and other sources.
> > > Any chance to add that to the site? 
> > 
> > I have posted  the diff at
> > http://www.openssi.org/contrib/linux-ssi.diff.gz
> 
> Hmmm, that's too huge to get an overview on what it does...
> The current CVS ci/kernel touches 137 files, openssi/kernel touches
> 350 files. Plus the ci/kernel.patches and openssi/kernel.patches...
> 
> > For 2.6 we are planning to group the changes into small 
> patches that is 
> >   easy to review.
> 
> Sounds great! Having groups sorted by functionality will help a
> lot. When will these be visible in the CVS?
> 
> Thanks,
> best regards,
> Erich
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the 
> changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source 
> Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> ssic-linux-devel mailing list
> ssic-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ssic-linux-devel
> 
