Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWHISsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWHISsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWHISse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:48:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33513 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751317AbWHISsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:48:33 -0400
Date: Wed, 9 Aug 2006 11:48:15 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] net driver fixes
Message-ID: <20060809184815.GB12941@kroah.com>
References: <20060809062539.GA27541@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809062539.GA27541@havoc.gtf.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:25:39AM -0400, Jeff Garzik wrote:
> 
> Please pull from 'upstream-greg' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-greg
> 
> to receive the following updates:
> 
>  drivers/net/myri10ge/myri10ge.c |    2 +-
>  net/core/wireless.c             |   24 +++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)

Applied, thanks.

greg k-h
