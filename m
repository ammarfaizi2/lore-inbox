Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUIILgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUIILgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUIILgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:36:43 -0400
Received: from open.hands.com ([195.224.53.39]:35791 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269390AbUIILgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:36:41 -0400
Date: Thu, 9 Sep 2004 12:47:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
Message-ID: <20040909114747.GC30162@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear linux kernel people,

i was staggered to find that swansmart (smlink.com) have a GPL
driver for their smart usb 56k modem.

they also do a pci version: their download supports both (usb+pci)

they also provide an AC97 ALSA driver (patch is against 2.6.0)

this PCI ALSA driver is based on the i8x0 / MX 440 modem driver,
by Jaroslav Kysela <perex@suse.cz>.

all their code is GPL.  this is very cool.


it is available here:

	http://www.smlink.com/main/down/slmodem-2.9.9.tar.gz

i trust that someone will download, check it, and if
appropriate, incorporate it into the mainstream linux kernel.

the swansmart usb 56k modem is dirt cheap (it was available in
the uk six months ago for about £9), and is extremely popular
in australia and the far east.

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

