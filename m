Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVGMWjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVGMWjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVGMWiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:38:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:37354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261539AbVGMWhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:37:10 -0400
Date: Wed, 13 Jul 2005 15:36:45 -0700
From: Greg KH <greg@kroah.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>, suresh.b.siddha@intel.com,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       ak@suse.de, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [stable] Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050713223645.GA5846@kroah.com>
References: <20050713184426.GM9330@kroah.com> <200507132205.j6DM5WJg020905@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507132205.j6DM5WJg020905@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 06:05:32PM -0400, Horst von Brand wrote:
> Greg KH <gregkh@suse.de> wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
> > Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
> > Cc: Andi Kleen <ak@muc.de>
> 
> Huh? Cc: in here?

Hold over from Andrew's scripts that add this.

thanks,

greg k-h
