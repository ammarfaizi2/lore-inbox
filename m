Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVAMAaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVAMAaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVALWsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:48:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:58256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVALWqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:46:15 -0500
Date: Wed, 12 Jan 2005 14:46:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050112144609.W24171@build.pdx.osdl.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <87r7kqe8ms.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87r7kqe8ms.fsf@deneb.enyo.de>; from fw@deneb.enyo.de on Wed, Jan 12, 2005 at 08:43:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer (fw@deneb.enyo.de) wrote:
> * Chris Wright:
> 
> > This same discussion is taking place in a few forums.  Are you opposed to
> > creating a security contact point for the kernel for people to contact
> > with potential security issues?
> 
> Would this be anything but a secretary in front of vendor-sec?

Yes, it'd be the primary contact for handling kernel security issues.
Handling vendor coordination is only one piece of a handling security
issue.

> > http://www.wiretrip.net/rfp/policy.html
> >
> > Right now most things come in via 1) lkml, 2) maintainers, 3) vendor-sec.
> > It would be nice to have a more centralized place for all of this
> > information to help track it, make sure things don't fall through
> > the cracks, and make sure of timely fix and disclosure.
> 
> You mean, like issuing *security* *advisories*? *gasp*

Yes, although we're not even tracking things well, let alone advisories.

> I think this is an absolute must (and we are certainly not alone!),
> but this project does not depend on the way the initial initial
> contact is handled.
> 
> > +      If it is a security bug, please copy the Security Contact listed
> > +in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.
> 
> If this is about delayed disclosure, a few more details are required,
> IMHO.  Otherwise, submitters will continue to use their
> well-established channels.  Most people hesitate before posting stuff
> they view sensitive to a mailing list.

Yes, that's the point of coordinating the fix _and_ the disclosure.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
