Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVB1Oe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVB1Oe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVB1OeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:34:17 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:56787 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261645AbVB1Oc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:32:58 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: martin f krafft <madduck@madduck.net>
Subject: Re: swsusp logic error?
Date: Mon, 28 Feb 2005 15:33:01 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050208203950.GA21623@cirrus.madduck.net> <20050227174309.GA27265@piper.madduck.net> <20050228135604.GA6364@piper.madduck.net>
In-Reply-To: <20050228135604.GA6364@piper.madduck.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502281533.01621.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 28 of February 2005 14:56, martin f krafft wrote:
> also sprach martin f krafft <madduck@madduck.net> [2005.02.27.1843 +0100]:
> > Please check my first post, if you have the time:
> > 
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=110789536921510&w=2
> 
> There is also
> 
>   http://thread.gmane.org/gmane.linux.acpi.devel/12540
> 
> with the same conclusion.
> 
> Maybe 2.6.11-rcX fixes this.

Could you, please, verify that you don't need to load any modules
from initrd for your swap partition to work?  It won't work if you do.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
