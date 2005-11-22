Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVKVQ2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVKVQ2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVKVQ2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:28:09 -0500
Received: from havoc.gtf.org ([69.61.125.42]:32134 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964980AbVKVQ2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:28:08 -0500
Date: Tue, 22 Nov 2005 11:28:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Josh Litherland <josh@emperorlinux.com>
Cc: linux-kernel@vger.kernel.org, research@emperorlinux.com
Subject: Re: SATA ICH6M problems on Sharp M4000
Message-ID: <20051122162808.GB32684@havoc.gtf.org>
References: <43824A6F.6070407@emperorlinux.com> <20051121234119.GD24565@havoc.gtf.org> <4383454D.4080400@emperorlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4383454D.4080400@emperorlinux.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 11:20:29AM -0500, Josh Litherland wrote:
> Jeff Garzik wrote:
> 
> > Expected behavior, since the default for module option atapi_enabled
> > is zero (disabled).
> 
> Thanks, turning this on makes everything work as expected.  Out of
> curiosity, in your opinion is atapi in libata still not quite ready for
> production use ?

If it was ready for production use, it would be enabled by default.

	Jeff



