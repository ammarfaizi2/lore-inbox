Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbUADJF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUADJF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:05:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:43740 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264600AbUADJF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:05:56 -0500
Date: Sun, 4 Jan 2004 00:57:59 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <rob@landley.net>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040104085759.GC27612@kroah.com>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <200401010634.28559.rob@landley.net> <900eUExXw-B@khms.westfalen.de> <200401020126.44234.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401020126.44234.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 01:26:44AM -0600, Rob Landley wrote:
> > Moral: keep the identifier creation framework flexible enough so that you
> > can chose device-specific means to produce useful identifiers. (And, use
> > long identifiers, as they're less likely to be duplicated in general.)
> 
> Seems to be what udev is for.  When we do go to random major and minor 
> numbers, maybe it would be useful to let udev request specific ones?  (Just a 
> thought...)

Let udev request specific what?  Major/minor numbers?  Huh?  I think you
are very confused here...

thanks,

greg k-h
