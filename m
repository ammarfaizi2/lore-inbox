Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWI2MJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWI2MJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 08:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWI2MJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 08:09:08 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:30652 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030212AbWI2MJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 08:09:06 -0400
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: tridge@samba.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	<17692.46192.432673.743783@samba.org>
	<17692.46192.432673.743783@samba.org>
	<1159515085.3880.78.camel@mulgrave.il.steeleye.com>
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Date: 29 Sep 2006 13:08:53 +0100
In-Reply-To: <1159515085.3880.78.camel@mulgrave.il.steeleye.com>
Message-ID: <r6ven6oox6.fsf@skye.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, once they comply with the distribution requirements,
> they're free to do whatever they want with the resulting OS in their
> printer ... including checking for only HP authorised ink
> cartridges.  You can take exception to this check and not buy the
> resulting printer, but you can't tell them not to do the check
> without telling them how they should be using the embedded platform.

I don't see where the GPLv3 forbids such checks.  Which section are
you thinking of?  In my understanding, it says only that HP must give
users the keys to install modified software.  From section 1 (of the
July draft):

  The Corresponding Source also includes any encryption or
  authorization keys necessary to install and/or execute modified
  versions from source code in the recommended or principal context of
  use, such that they can implement all the same functionality in the
  same range of circumstances.

So the user, having the keys, can remove the cartridge check.  HP
might not like it and may choose not to distribute GPLv3 software with
the printer, but that's a separate story.

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.
