Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTFFWLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTFFWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:11:16 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:760 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S262320AbTFFWLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:11:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: short freezing while file re-creation
Date: Fri, 6 Jun 2003 18:21:57 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB020EC0D3@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: short freezing while file re-creation
Thread-Index: AcMsXwezRs6JMgjdSt26mIqUA1PXqgAGQfRw
From: "Lauro, John" <jlauro@umflint.edu>
To: "Oleg Drokin" <green@namesys.com>, "Chris Mason" <mason@suse.com>
Cc: "Stephan von Krawczynski" <skraw@ithnet.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Oleg Drokin [mailto:green@namesys.com]
> Sent: Friday, June 06, 2003 3:10 PM
> To: Chris Mason
> Cc: Stephan von Krawczynski; linux-kernel
> Subject: Re: short freezing while file re-creation
> 
> Hello!
> 
> On Fri, Jun 06, 2003 at 03:00:54PM -0400, Chris Mason wrote:
> 
> > There are still some latency issues with io in rc7, it could be a
> > general problem.
> 
> Hm. But I think everything that was not needing disk io (i.e. mouse
stuff)
> should not be affected?

There is still some *serious* issues on machines with large amounts of
memory and the default VM.  Maybe they happen in smaller memory
systems too, just smaller boxes recover quicker?

