Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbVJTAdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbVJTAdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 20:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbVJTAdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 20:33:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:48835 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751664AbVJTAdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 20:33:43 -0400
Date: Wed, 19 Oct 2005 16:44:29 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: Mathieu Segaud <matt@regala.cx>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
Message-ID: <20051019234429.GD18295@kroah.com>
References: <1129610113.10504.4.camel@localhost> <20051018055003.GA10488@kroah.com> <20051018065705.GA11858@kroah.com> <87r7ajdy4v.fsf@barad-dur.minas-morgul.org> <20051019034427.GA15940@kroah.com> <1129701608.10192.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129701608.10192.1.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 11:00:08PM -0700, Aaron Gyes wrote:
> On Tue, 2005-10-18 at 20:44 -0700, Greg KH wrote:
> > I was against my latest tree, which is on kernel.org.  Someone already
> > posted an updated patch on lkml if you can't get that second hunk to
> > apply.
> 
> I applied that, and I still don't see the node being created. 

Yeah, sorry.

You need a udev update.  071 has been released which should fix this
problem (fixes it for me.)  Can you try that out?

thanks,

greg k-h
