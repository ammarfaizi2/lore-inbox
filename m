Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWDSU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWDSU74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDSU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:59:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:13282 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751243AbWDSU7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:59:55 -0400
Date: Wed, 19 Apr 2006 15:59:48 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060419205948.GA16229@sergelap.austin.ibm.com>
References: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.61.0604192109220.7177@yvahk01.tjqt.qr> <20060419204824.GB21987@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419204824.GB21987@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH (greg@kroah.com):
> On Wed, Apr 19, 2006 at 09:22:07PM +0200, Jan Engelhardt wrote:
> > In general: I am probably too strongly tied to my own CodingStyle to
> > change it for Documentation/CodingStyle.
> 
> There's a very good reason the kernel has a consistant coding style, so
> if you don't want to adapt to it, do not expect to ever get your code
> accepted, it's that simple.
> 
> Sorry to hear that such a trivial thing is going to trip you up.

Greg,

I think what really tripped him up was the response to his attempt
to get the new hooks introduced:  tinyurl.com/opo8h

Jan,

I think that the last response, by Chrisw, in that thread, was not
a snide comment, but a legitimate request for a justification for
the hooks.  If they are a crucial part of your module, then i assume
they should be pretty easy for you to defend, right?

I think it would be worth trying again.

-serge
