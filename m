Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUF2QZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUF2QZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUF2QZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 12:25:36 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:40394 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id S265799AbUF2QZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 12:25:33 -0400
Date: Tue, 29 Jun 2004 09:23:39 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>
Subject: Updated Wireless Extension patches
Message-ID: <20040629162339.GA4356@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0, required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

	I've been working a bit more on my current set of Wireless
Extension patches (WPA, Wireless-RtNetlink, ...). I've just updated
them on my personal web page :
	http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html#wext

	The main change is that I'm now happy of the format of
Wireless over RtNetlink, so it should be close to definitive. I've
also split all the minor changes as a separate patch (WE-17), so it
doesn't have to wait for WPA and Wireless-RtNetlink that still need a
bit of work, and I plan to push this patch soon.
	You will also find patches for various drivers to take
advantage of the new features. I would like to thank the various
driver authors that sent me patches, suggestions and comments, and
thank them for their patience.

	Have fun...

	Jean

