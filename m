Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVCPSTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVCPSTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCPSTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:19:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:21972 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261296AbVCPST1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:19:27 -0500
Date: Wed, 16 Mar 2005 10:16:44 -0800
From: Greg KH <greg@kroah.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.4
Message-ID: <20050316181644.GG20576@kroah.com>
References: <20050316002222.GA30602@kroah.com> <m3u0nbybu8.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u0nbybu8.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 02:11:43PM +0100, Krzysztof Halasa wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > I've release 2.6.11.4 with two security fixes in it.  It can be found at
> > the normal kernel.org places.
> 
> How about the N2/C101/PCI200SYN WAN driver fix (kernel panic on receive)?
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

It's queued up for the "normal" review process (will probably start
tomorrow, or later today.)  This release was due to the ppp issue being
public.

thanks,

greg k-h
