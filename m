Return-Path: <linux-kernel-owner+w=401wt.eu-S1750949AbXAOR07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXAOR07 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbXAOR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:26:59 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:37396 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbXAOR07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:26:59 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 15 Jan 2007 12:17:37 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Tilman Schmidt <tilman@imap.cc>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, kkeil@suse.de
Subject: Re: any value to fixing apparent bugs in old ISDN4Linux?
In-Reply-To: <45ABB53C.5030100@imap.cc>
Message-ID: <Pine.LNX.4.64.0701151216310.7260@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
 <45ABB53C.5030100@imap.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Tilman Schmidt wrote:

> Robert P. J. Day schrieb:
> >   OTOH, since that code *is* in the allegedly obsolete old ISDN4Linux
> > code, perhaps that entire part of the tree can just be junked.  but if
> > it's sticking around, it should probably be fixed.
>
> Please do not remove isdn4linux just yet. It's true that it has been
> marked as obsolete for quite some time, but it's still needed
> anyway. Its designated successor, the CAPI subsystem, so far only
> supports a very limited range of hardware. Dropping isdn4linux now
> would leave the owners of some very popular ISDN cards out in the
> cold.

that wouldn't be my decision, i just made a note of an oddity.  but if
it's still in actual use, then it really should be re-labelled from
"obsolete" to "deprecated," no?

rday
