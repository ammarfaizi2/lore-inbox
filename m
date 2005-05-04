Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVEDEWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVEDEWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 00:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEDEWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 00:22:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:62106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262011AbVEDEV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 00:21:58 -0400
Date: Tue, 3 May 2005 21:21:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: no more "applied, thanks" emails from me.
Message-ID: <20050504042157.GA16103@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a short note to know that I'll probably not be sending any kind of
ACK message out to the mailing list anymore when I apply patches to my
tree.  Instead, the patch submitter will get a message when it gets
applied, that contains a bunch of info about what patch it was, and
others that they have pending in my tree.  (I blatently stole Andrew's
patch that also does this, and tweaked it to work in my patchflow.)

I'm doing this as I had been generating those "applied, thanks" emails
by hand, and have been getting tired of them, and I know that some
people were getting annoyed by this type of message (so much so that
they generated procmail filters to keep from having to see them.)  

This new method should also be easier for me to apply more patches
faster, which is always a good thing.

And yes, sometimes these messages will escape and hit the mailing list
due to me forgetting to filter out that email address.  If that happens,
sorry, my script isn't that smart...

thanks,

greg k-h
