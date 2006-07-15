Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945991AbWGOEWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945991AbWGOEWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWGOEWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:22:05 -0400
Received: from tomts28.bellnexxia.net ([209.226.175.102]:63962 "EHLO
	tomts28-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1945991AbWGOEWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:22:04 -0400
Date: Fri, 14 Jul 2006 21:20:46 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
Subject: Re: [stable] Linux 2.6.17.5
Message-ID: <20060715042045.GB4322@kroah.com>
References: <20060715030047.GC11167@kroah.com> <20060715032834.GA5944@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715032834.GA5944@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 08:28:34PM -0700, Greg KH wrote:
> On Fri, Jul 14, 2006 at 08:00:47PM -0700, Greg KH wrote:
> > We (the -stable team) are announcing the release of the 2.6.17.5 kernel.
> 
> Oops, please note that we now have some reports that this patch breaks
> some versions of HAL.  So if you're relying on HAL, you might not want
> to use this fix just yet (please evaluate the risks of doing this on
> your own.)

Hm, HAL 0.5.7 seems to work fine for me.  Anyone else seeing any
problems with this version?  Older versions?

thanks,

greg k-h
