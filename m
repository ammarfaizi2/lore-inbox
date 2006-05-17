Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWEQByP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWEQByP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWEQByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:54:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:32970 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932424AbWEQByO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:54:14 -0400
Date: Tue, 16 May 2006 18:40:10 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, Stephen Street <stephen@streetfiresound.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 09/10] spi: Update to PXA2xx SPI Driver
Message-ID: <20060517014010.GA1800@kroah.com>
References: <1147815518968-git-send-email-greg@kroah.com> <adamzvu9fhf.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adamzvu9fhf.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 04:10:04PM -0800, Roland Dreier wrote:
> This is kind of a weird way to do things: the PXA2xx SPI driver was
> just added in patch 2/10.  Why merge a known-buggy driver and then fix
> it as part of the same merge?

Because it was built up as a series of patches, and I didn't merge any
of them together like I should have :)

Anyway, David will be taking care of these now, so hopefully stuff like
this will not happen again.

thanks,

greg k-h
