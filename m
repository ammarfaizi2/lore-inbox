Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVF1Oso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVF1Oso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVF1Osg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:48:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVF1Ora (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:47:30 -0400
Date: Tue, 28 Jun 2005 07:47:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jim MacBaine <jmacbaine@gmail.com>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] Re: [00/07] -stable review
Message-ID: <20050628144706.GX9046@shell0.pdx.osdl.net>
References: <20050627224651.GI9046@shell0.pdx.osdl.net> <3afbacad050628051059b69bbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3afbacad050628051059b69bbe@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jim MacBaine (jmacbaine@gmail.com) wrote:
> On 6/28/05, Chris Wright <chrisw@osdl.org> wrote:
> 
> > Responses should be made by Wed, Jun 29, 23:00 UTC.  Anything received after
> > that time, might be too late.
> 
> Will the fix for the iptables physdev match go into -stable?

I assume you're referring to this fix:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111936734211687&w=2

If so, I expect it will.  Needs to hit mainline first and get pushed over
to -stable.
