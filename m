Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFKQ60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFKQ60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFKQ60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:58:26 -0400
Received: from mail.suse.de ([195.135.220.2]:44707 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750734AbWFKQ60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:58:26 -0400
Date: Sun, 11 Jun 2006 09:55:51 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Anne Thrax <foobarfoobarfoobar@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Removal of security/root_plug.c
Message-ID: <20060611165551.GA18032@kroah.com>
References: <448B5449.2030605@gmail.com> <Pine.LNX.4.61.0606111243350.13585@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606111243350.13585@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2006 at 12:43:55PM +0200, Jan Engelhardt wrote:
> >Hello all,
> >
> >Apparently security/root_plug.c was written for a Linux Journal article,
> >and while it does do a good job of explaining LSM, I don't see much use for
> >it in the mainstream kernel. I suggest that it be removed, because I don't
> >think that it serves much purpose. I doubt that anyone actually uses this,
> >for if they did, I think that it would be modified and have many additions.
> >Even the author states that it is just a starting point. Maybe the article
> >(if Linux Journal is okay with it) along with the code should be moved to
> >Documentation/?
> >
> At least it should be kept in the new DDK Greg released, if it is going to 
> be removed from mainline.

It's not going to be removed any time soon.

thanks,

greg k-h
