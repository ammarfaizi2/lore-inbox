Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUHKXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUHKXBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUHKW7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:59:07 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:52712 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S268306AbUHKW4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:56:18 -0400
Date: Thu, 12 Aug 2004 00:56:12 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: David Woodhouse <postmaster@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811225612.GB14073@louise.pinerecords.com>
References: <411A478E.1080101@linux.intel.com> <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net> <20040811163333.GE10100@louise.pinerecords.com> <20040811175105.A30188@infradead.org> <20040811170208.GG10100@louise.pinerecords.com> <20040811181142.A30309@infradead.org> <20040811172222.GI10100@louise.pinerecords.com> <20040811184148.A30660@infradead.org> <20040811175109.GJ10100@louise.pinerecords.com> <1092264200.1438.4347.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092264200.1438.4347.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-11 2004, Wed, 23:43 +0100
David Woodhouse <postmaster@infradead.org> wrote:

> On Wed, 2004-08-11 at 19:51 +0200, Tomas Szepe wrote:
> > 550-Verification failed for <szepe@pinerecords.com>
> > 550-(result of earlier verification reused).
> > 550 Sender verify failed
> > 
> > I for one don't call this a properly configured mail system.
> 
> Indeed it isn't. It doesn't accept mail to 'postmaster@pinerecords.com',
> which is in violation of RFC2821. Hence we don't accept mail from it.
> 
> 2004-08-11 17:33:36 H=louise.pinerecords.com [213.168.176.16] sender
> verify fail for <kala@pinerecords.com>: response to "RCPT
> TO:<postmaster@pinerecords.com>" from louise.pinerecords.com
> [213.168.176.16] was: 553 5.3.0 <postmaster@pinerecords.com>... No such
> user
> 
> 2004-08-11 17:33:36 H=louise.pinerecords.com [213.168.176.16]
> F=<kala@pinerecords.com> rejected RCPT <hch@infradead.org>: Sender
> verify failed

Ok, thanks for the warning.  Is there any reason why you should
be trying to look up postmaster@ from the sender domain upon
RCPT TO?

-- 
Tomas Szepe <szepe@pinerecords.com>
