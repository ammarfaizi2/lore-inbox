Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264796AbUEER4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbUEER4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbUEER4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:56:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:17836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264796AbUEERyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:54:13 -0400
Date: Wed, 5 May 2004 10:53:23 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6]
Message-ID: <20040505175323.GA13088@kroah.com>
References: <409923F7.7050101@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409923F7.7050101@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 07:27:19PM +0200, Michael Hunold wrote:
> 
> I think these things are unquestionable and don't make any functional 
> changes to the code, so this should be applied to 2.6 now.

"now" as in 2.6.6-rc3?  No.

Now as in I'll add it to my i2c tree, which will get picked up by -mm
and let it bake a bit and then pushed to Linus, yes.

I'll look this over and add it to my tree, thanks,

greg k-h
