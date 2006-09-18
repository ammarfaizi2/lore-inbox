Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWIRMyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWIRMyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWIRMyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:54:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:9677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965119AbWIRMyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:54:40 -0400
Date: Mon, 18 Sep 2006 05:44:25 -0700
From: Greg KH <greg@kroah.com>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting array data in sysfs
Message-ID: <20060918124425.GA8304@kroah.com>
References: <200609181359.31489.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181359.31489.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 01:59:17PM +0200, Rolf Eike Beer wrote:
> Hi,
> 
> I would like to put the contents of an array in sysfs files. I found no simple 
> way to do this, so here are my thoughts in hope someone can hand me a light.

What is wrong with using an attribute group for this kind of
information?

And do you have an example of a place in the kernel where this would be
necessary?

thanks,

greg k-h
