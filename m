Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCPT14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCPT12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:27:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:208 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261244AbUCPT0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:26:34 -0500
Date: Tue, 16 Mar 2004 11:24:59 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
Message-ID: <20040316192458.GB21172@kroah.com>
References: <4056B0DB.9020008@pobox.com> <20040316005229.53e08c0c.akpm@osdl.org> <20040316153719.GA13723@kroah.com> <20040316111026.6729e153.akpm@osdl.org> <40575279.7040408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40575279.7040408@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 02:16:09PM -0500, Jeff Garzik wrote:
> 
> Bryan O'Sullivan and Greg KH at varying times in the past had BK trees, 
> but I didn't know of any up-to-date one.

I think Bryan was trying to keep his bk tree up to date with the klibc
cvs tree, but don't know how well that went.

> Note that it isn't my intention to become klibc maintainer...  just in 
> case anybody started getting ideas... :)

I thought hpa was the klibc maintainer, you're just offering a patch to
add it to the build :)

thanks,

greg k-h
