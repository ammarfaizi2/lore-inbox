Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVAUHxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVAUHxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAUHwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:52:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:50408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262312AbVAUHw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:52:28 -0500
Date: Thu, 20 Jan 2005 23:46:01 -0800
From: Greg KH <greg@kroah.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: karim@opersys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
Message-ID: <20050121074601.GA19550@kroah.com>
References: <41EF4E74.2000304@opersys.com> <20050120145046.GF13036@kroah.com> <41F05D11.5020109@opersys.com> <41F065C0.7070603@bigpond.net.au> <20050121063956.GB19288@kroah.com> <41F0AEEF.8060707@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F0AEEF.8060707@bigpond.net.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 06:27:43PM +1100, Peter Williams wrote:
> Greg KH wrote:
> >On Fri, Jan 21, 2005 at 01:15:28PM +1100, Peter Williams wrote:
> >
> >>Perhaps the logical solution is to implement debugfs in terms of relayfs?
> >
> >
> >What do you mean by this statement?
> 
> I mean that if, as you say, debugfs is very similar to relayfs only more 
> restricted (i.e. a debugging option) then it should be implementable as 
> an instance or specialization of the more general relayfs and that this 
> should be a better solution than two independent implementations of 
> similar functionality.

Ah.

No.

The implementations are not of the same functionality, or so Karim says.

thanks,

greg k-h
