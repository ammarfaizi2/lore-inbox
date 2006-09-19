Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWISPTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWISPTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWISPTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:19:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:23963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750709AbWISPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:19:31 -0400
Date: Tue, 19 Sep 2006 07:22:15 -0700
From: Greg KH <greg@kroah.com>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-ID: <20060919142215.GB29190@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org> <20060919130848.GA42927@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060919130848.GA42927@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2006 at 03:08:49PM +0200, Olivier Galibert wrote:
> On Tue, Sep 19, 2006 at 01:28:48AM -0700, Andrew Morton wrote:
> > - The kernel doesn't work properly on RH FC3 or pretty much anything
> >   which uses old udev, due to improvements in the driver tree.
> 
> Breaking compatibility again?  I thought the sysfs/driver tree
> maintainers free pass had expired.

"again"?  No, this is the same breakage as before, nothing new here,
move along... :)

thanks,

greg k-h
