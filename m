Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJAXcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJAXcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:32:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:53925 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263007AbTJAXcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:32:12 -0400
Date: Wed, 1 Oct 2003 16:32:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       vserver@solucorp.qc.ca
Subject: Re: sys_vserver
Message-ID: <20031001163203.U14398@osdlab.pdx.osdl.net>
References: <20031001161442.B14425@osdlab.pdx.osdl.net> <Pine.LNX.4.44.0310011916260.4454-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0310011916260.4454-100000@chimarrao.boston.redhat.com>; from riel@redhat.com on Wed, Oct 01, 2003 at 07:17:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rik van Riel (riel@redhat.com) wrote:
> On Wed, 1 Oct 2003, Chris Wright wrote:
> > * James Morris (jmorris@redhat.com) wrote:
> > > I think virtualization is important/useful enough to warrant an API of
> > > it's own.  It could be similar to LSM, e.g.  allow pluggable
> > > virtualization modules, with no cost for the base kernel.
> > 
> > Doesn't sound like 2.6 material.
> 
> Maybe not, but it does sound like something we want to be
> ready by the time 2.7 is forked ;)

Yes, good point ;-)  And I do agree it's a useful concept.
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
