Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWDSVF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWDSVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWDSVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:05:58 -0400
Received: from xenotime.net ([66.160.160.81]:2766 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751120AbWDSVF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:05:57 -0400
Date: Wed, 19 Apr 2006 14:08:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: jengelh@linux01.gwdg.de, jmorris@namei.org, hch@infradead.org,
       akpm@osdl.org, sds@tycho.nsa.gov, edwin@gurde.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, torvalds@osdl.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
 implementation of LSM hooks)
Message-Id: <20060419140820.73b93f85.rdunlap@xenotime.net>
In-Reply-To: <20060419204824.GB21987@kroah.com>
References: <200604142301.10188.edwin@gurde.com>
	<1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	<20060417162345.GA9609@infradead.org>
	<1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	<20060417173319.GA11506@infradead.org>
	<Pine.LNX.4.64.0604171454070.17563@d.namei>
	<20060417195146.GA8875@kroah.com>
	<Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	<20060419154011.GA26635@kroah.com>
	<Pine.LNX.4.61.0604192109220.7177@yvahk01.tjqt.qr>
	<20060419204824.GB21987@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 13:48:24 -0700 Greg KH wrote:

> On Wed, Apr 19, 2006 at 09:22:07PM +0200, Jan Engelhardt wrote:
> > In general: I am probably too strongly tied to my own CodingStyle to
> > change it for Documentation/CodingStyle.
> 
> There's a very good reason the kernel has a consistant coding style, so
> if you don't want to adapt to it, do not expect to ever get your code
> accepted, it's that simple.
> 
> Sorry to hear that such a trivial thing is going to trip you up.

I agree.  It sounded like an excuse to me, not a justifiable
reason.

---
~Randy
