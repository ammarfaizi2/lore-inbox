Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVLQBmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVLQBmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVLQBmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:42:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:3757 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751353AbVLQBmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:42:38 -0500
Date: Fri, 16 Dec 2005 17:42:10 -0800
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm3
Message-ID: <20051217014209.GA5329@kroah.com>
References: <20051214234016.0112a86e.akpm@osdl.org> <20051216231752.GA2731@kroah.com> <20051217011524.6d4a1caa@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217011524.6d4a1caa@werewolf.auna.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 01:15:24AM +0100, J.A. Magallon wrote:
> On Fri, 16 Dec 2005 15:17:52 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > On Wed, Dec 14, 2005 at 11:40:16PM -0800, Andrew Morton wrote:
> > >   Probably-unfixed bugs from -mm1 and -mm2 include:
> > > 
> > >   - "J.A. Magallon" <jamagallon@able.es>: usb_set_configuration() oops.
> > 
> > Now fixed in my tree.
> > 
> 
> What did Andrew's phrase exactly mean ?
> - Still unfixed in -mm3, or
> - Unfixed 'till mm2, but fixed in mm3, but not picked by you
> 
> I suppose the second, because the fix is present in -mm3.

Good, thanks for letting us know.

greg k-h
