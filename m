Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUFIOQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUFIOQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 10:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFIOQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 10:16:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:41876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265772AbUFIOQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 10:16:52 -0400
Date: Wed, 9 Jun 2004 07:15:31 -0700
From: Greg KH <greg@kroah.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Chris Wright <chrisw@osdl.org>, Amon Ott <ao@rsbac.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dev@grsecurity.net
Subject: Re: security patches / lsm
Message-ID: <20040609141530.GA17451@kroah.com>
References: <20040122191158.GA1207@schottelius.org> <20040122150937.A8720@osdlab.pdx.osdl.net> <20040609090346.GG601@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609090346.GG601@schottelius.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:03:46AM +0200, Nico Schottelius wrote:
> Sorry for the late answer!
> 
> For me it looks like rsbac and grsecurity could get included in 2.6.
> 
> It looks like Amon did the work necessary to intergrate it into 2.6.
> (have a look at http://www.rsbac.org/).
> 
> And grsecurity also works nice with 2.6
> (http://www.grsecurity.net/download.php).
> 
> Who decides whether to integrate them or not?

They need to actually submit the patches for inclusion, which both
groups have not done.

thanks,

greg k-h
