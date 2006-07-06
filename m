Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWGFRd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWGFRd2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGFRd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:33:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:19599 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030320AbWGFRd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:33:27 -0400
Date: Thu, 6 Jul 2006 10:29:31 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
Message-ID: <20060706172931.GA4259@kroah.com>
References: <1152191265.2987.154.camel@pmac.infradead.org> <1152191482.2987.157.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152191482.2987.157.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 02:11:22PM +0100, David Woodhouse wrote:
> gregkh-usb-usb-gotemp.patch
> gregkh-usb-usb-serial-mos7720.patch

I'll fix these two, they should not have had that #include at all...

thanks,

greg k-h
