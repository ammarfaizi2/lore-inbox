Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLYBJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 20:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTLYBJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 20:09:31 -0500
Received: from crisium.vnl.com ([194.46.8.33]:34314 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S264229AbTLYBJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 20:09:30 -0500
Date: Thu, 25 Dec 2003 01:09:25 +0000
From: Dale Amon <amon@vnl.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on LFS in Redhat
Message-ID: <20031225010925.GG4987@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <20031223151042.GE9089@vnl.com> <1072193917.5262.1.camel@laptop.fenrus.com> <20031223235827.GK9089@vnl.com> <20031224084903.GB20976@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031224084903.GB20976@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 09:49:03AM +0100, Arjan van de Ven wrote:
> You really shouldn't be running a 2.4.16 kernel (not without the latest
> security patches for such a kernel from a distro) given the amount of security issues
> fixed since... and since I don't think any distro ever shipped 2.4.16 (some
> shipped 2.4.17, a bunch shipped 2.4.18 but even RH doesn't do patches for
> that 2.4.18 tree anymore since they have been obsoleted by 2.4.20 and newer
> kernels).

Not really my choice... and from what you say I'd better
not *touch* their stock kernel if I a project for which I 
specced that box happens.

Also, fresh feedback from the Consensys is that:

	"Just to be precise - As of today the kernel 
	 is 2.4.18-i59smp #1"

So that is a little better but still a little out
of date. I'm not terribly worried about the local
exploit because you don't tend to want to allow external
login accounts on things on your SAN's...

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
