Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266363AbUGOVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266363AbUGOVRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGOVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:17:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266363AbUGOVQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:16:51 -0400
Date: Thu, 15 Jul 2004 23:16:43 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: mauelshagen@redhat.com,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: *** Announcement: dmraid 1.0.0-rc2 ***
Message-ID: <20040715211643.GF25375@redhat.com>
Reply-To: mauelshagen@redhat.com
References: <20040715203553.GA18640@redhat.com> <1089924538.9014.34.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089924538.9014.34.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 10:48:58PM +0200, Martin Schlemmer wrote:
> On Thu, 2004-07-15 at 22:35, Heinz Mauelshagen wrote:
> >                *** Announcement: dmraid 1.0.0-rc2 ***
> > 
> > Following a good tradition, dmraid 1.0.0-rc2 is available at
> > http://people.redhat.com:/~heinzm/sw/dmraid/ in source and i386 rpm,
> > before I leave for a 2 weeks vacation trip followed by LWE ;)
> > 
> 
> Not really on topic for this list, but was wondering if anybody
> else have that it only loops on dep generation during make
> (rc1 did it as well) ?

Odd, I had that with make 3.80 but not with 3.79.1...
I thought that it was some strange timestamp but the make version
made the difference.

Any hints welcome.

> 
> 
> -- 
> Martin Schlemmer



-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
