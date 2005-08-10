Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVHJUzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVHJUzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 16:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVHJUzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 16:55:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:48806 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030265AbVHJUzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 16:55:07 -0400
Date: Wed, 10 Aug 2005 13:49:32 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linas@austin.ibm.com
Subject: Re: [RFC/PATCH] Add pci_walk_bus function to PCI core
Message-ID: <20050810204932.GA31701@kroah.com>
References: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17145.23098.798473.364481@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 11:36:58AM +1000, Paul Mackerras wrote:
> Greg,
> 
> Any comments on this patch?  Would you be amenable to it going in post
> 2.6.13?

Looks fine to me.  I'll hold off on applying as you said you were going
to try to get a version without recursion.

thanks,

greg k-h
