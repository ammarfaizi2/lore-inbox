Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVALTsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVALTsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVALTpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:45:04 -0500
Received: from mail.enyo.de ([212.9.189.167]:3050 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261336AbVALTnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:43:10 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <20050112094807.K24171@build.pdx.osdl.net>
Date: Wed, 12 Jan 2005 20:43:07 +0100
In-Reply-To: <20050112094807.K24171@build.pdx.osdl.net> (Chris Wright's
	message of "Wed, 12 Jan 2005 09:48:07 -0800")
Message-ID: <87r7kqe8ms.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright:

> This same discussion is taking place in a few forums.  Are you opposed to
> creating a security contact point for the kernel for people to contact
> with potential security issues?

Would this be anything but a secretary in front of vendor-sec?

> http://www.wiretrip.net/rfp/policy.html
>
> Right now most things come in via 1) lkml, 2) maintainers, 3) vendor-sec.
> It would be nice to have a more centralized place for all of this
> information to help track it, make sure things don't fall through
> the cracks, and make sure of timely fix and disclosure.

You mean, like issuing *security* *advisories*? *gasp*

I think this is an absolute must (and we are certainly not alone!),
but this project does not depend on the way the initial initial
contact is handled.

> +      If it is a security bug, please copy the Security Contact listed
> +in the MAINTAINERS file.  They can help coordinate bugfix and disclosure.

If this is about delayed disclosure, a few more details are required,
IMHO.  Otherwise, submitters will continue to use their
well-established channels.  Most people hesitate before posting stuff
they view sensitive to a mailing list.
