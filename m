Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263631AbUDZWRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUDZWRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUDZWRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 18:17:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:60314 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263631AbUDZWRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 18:17:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: Kernel Oops during usb usage (2.6.5)
Date: Tue, 27 Apr 2004 00:17:34 +0200
User-Agent: KMail/1.5.1
Cc: "E. Oltmanns" <oltmanns@uni-bonn.de>, linux-kernel@vger.kernel.org
References: <20040423205617.GA1798@local> <408D4187.2040104@tmr.com> <20040426195359.GA29062@kroah.com>
In-Reply-To: <20040426195359.GA29062@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404270017.34478.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. April 2004 21:53 schrieb Greg KH:
> On Mon, Apr 26, 2004 at 01:06:15PM -0400, Bill Davidsen wrote:
> > Just in general, if there is anything a non-root user can do to crash
> > the system, it's probably a kernel bug by definition. It doesn't matter
> > that's it a stupid thing to do, it might be malicious. And in this case
> > it might just be user error.
>
> But you either have to be root in order to talk to usbfs, or you were
> root when you gave a user access to the usbfs node.  So either way, a
> "normal" user can't even do this.

Greg,

that's not an answer. It in effect means that usbfs is useless.

	Regards
		Oliver

