Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUI1WBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUI1WBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268060AbUI1WBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:01:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:29355 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268059AbUI1WBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:01:10 -0400
Date: Tue, 28 Sep 2004 14:56:20 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Message-ID: <20040928215620.GA13816@kroah.com>
References: <1096302710971@topspin.com> <10963027102899@topspin.com> <20040927131014.695b8212.pj@sgi.com> <52fz53e526.fsf@topspin.com> <20040927234333.7cceff47.pj@sgi.com> <52mzzacsyk.fsf@topspin.com> <20040928090032.292d12e8.pj@sgi.com> <52wtyebcde.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wtyebcde.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 09:13:17AM -0700, Roland Dreier wrote:
>     Paul> Perhaps - but perhaps also I've shown you ways to use a
>     Paul> function with fewer non-const variables.
> 
> Yeah, you've convinced me.  I'll reroll my patches.

Ok, I've thrown away your old ones :)

thanks,

greg k-h
