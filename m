Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWG3Izk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWG3Izk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 04:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWG3Izj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 04:55:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:2738 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932067AbWG3Izj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 04:55:39 -0400
Date: Sun, 30 Jul 2006 01:51:15 -0700
From: Greg KH <greg@kroah.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060730085115.GA17759@kroah.com>
References: <06ATUBD12@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ATUBD12@briare1.heliogroup.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 12:21:13PM +0000, Hubert Tonneau wrote:
> Off topic information:
> With 2.6.17, none of my USB sound cards works; all of them work with 2.6.16

That's not good at all.  Care to run 'git bisect' on the tree to find
out what patch caused it?

thanks,

greg k-h
