Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUCCIAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUCCIAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:00:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:62729 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262418AbUCCIAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:00:38 -0500
Date: Wed, 3 Mar 2004 08:00:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4-rc1
Message-ID: <20040303080037.A25883@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <10782873983442@kroah.com> <10782873981292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10782873981292@kroah.com>; from greg@kroah.com on Tue, Mar 02, 2004 at 08:16:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 08:16:38PM -0800, Greg KH wrote:
> ChangeSet 1.1612.17.5, 2004/02/27 11:40:29-08:00, masbock@us.ibm.com
> 
> [PATCH] Driver for IBM service processor - updated (1/2)

please don't put anything into drivers/misc for now.  We might over to it,
but then we should do it for all drivers we think it makes sense instead
of random ones.

