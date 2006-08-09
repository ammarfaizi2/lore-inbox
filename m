Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWHISsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWHISsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWHISsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:48:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:10978 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751316AbWHISsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:48:10 -0400
Date: Wed, 9 Aug 2006 11:47:49 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
Message-ID: <20060809184749.GA12941@kroah.com>
References: <20060809062514.GA27491@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809062514.GA27491@havoc.gtf.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 02:25:14AM -0400, Jeff Garzik wrote:
> 
> Please pull from 'upstream-greg' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg

Applied, thanks.

Hm, should these fixes solve my SATA cdrom driver timeout issue?  I'll
go test that, it was still broken in 2.6.18-rc4...

thanks,

greg k-h
