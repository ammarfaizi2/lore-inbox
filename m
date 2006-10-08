Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWJHG16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWJHG16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWJHG16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:27:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:33442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750832AbWJHG15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:27:57 -0400
Date: Sat, 7 Oct 2006 19:39:30 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, dbrownell@users.sourceforge.net,
       Arnd Bergmann <arnd@arndb.de>, support@moschip.com,
       Michael Helmling <supermihi@web.de>, linux-kernel@vger.kernel.org,
       David Hollis <dhollis@davehollis.com>
Subject: Re: [linux-usb-devel] [PATCH 1/3] driver for mcs7830 (aka DeLOCK) USB ethernet adapter
Message-ID: <20061008023930.GA10198@kroah.com>
References: <200609170102.50856.arnd@arndb.de> <200609271828.58205.david-b@pacbell.net> <200610072058.26162.arnd@arndb.de> <200610071316.45545.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610071316.45545.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2006 at 01:16:44PM -0700, David Brownell wrote:
> On Saturday 07 October 2006 11:58 am, Arnd Bergmann wrote:
> > On Thursday 28 September 2006 03:28, David Brownell wrote:
> > > On Saturday 16 September 2006 4:02 pm, Arnd Bergmann wrote:
> > > > This driver adds support for the DeLOCK USB ethernet adapter
> > > > and potentially others based on the MosChip MCS7830 chip.
> > > > 
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> > > 
> > 
> > David, I was under the assumption that you would submit this version
> > for inclusion in 2.6.19. Do you have it queued somewhere for submission
> > or did you expect me to send it to someone else?
> 
> I was expecting Greg to do his usual fine job and pick it up
> for his next set of USB patches.  But you could probably
> speed the process up by resending it to him.  2.6.19 seems
> right to me.  (Hmm, I don't think your other two patches
> got merged either ...)

If I don't get CC:ed, I can miss it at times.  Feel free to resend it to
me.

thanks,

greg k-h
