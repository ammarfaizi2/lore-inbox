Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWDSUtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWDSUtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDSUtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:49:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13749 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751120AbWDSUtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:49:39 -0400
Date: Wed, 19 Apr 2006 13:48:24 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060419204824.GB21987@kroah.com>
References: <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.61.0604192109220.7177@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604192109220.7177@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 09:22:07PM +0200, Jan Engelhardt wrote:
> In general: I am probably too strongly tied to my own CodingStyle to
> change it for Documentation/CodingStyle.

There's a very good reason the kernel has a consistant coding style, so
if you don't want to adapt to it, do not expect to ever get your code
accepted, it's that simple.

Sorry to hear that such a trivial thing is going to trip you up.

greg k-h
