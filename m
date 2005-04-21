Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDUEDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDUEDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 00:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDUEDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 00:03:16 -0400
Received: from orb.pobox.com ([207.8.226.5]:5509 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261204AbVDUEDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 00:03:13 -0400
Date: Wed, 20 Apr 2005 21:03:06 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clem@clem.clem-digital.net
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421040306.GA10516@ip68-225-251-162.oc.oc.cox.net>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.12-rc3 is still missing the following compile fixes:

[PATCH] fix ultrastor.c compile error
http://marc.theaimsgroup.com/?l=linux-scsi&m=111391774018717&w=2

[PATCH] fix aic7xxx_osm.c compile failure (gcc 2.95.x only)
http://marc.theaimsgroup.com/?l=linux-scsi&m=111391769011616&w=2

[linux-usb-devel] Re: [PATCH] fix microtek.c compile failure
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=111391865311903&w=2

Another LKML poster (who I added to CC on this message) already hit the
aic7xxx compile failure with 2.6.12-rc3...

-Barry K. Nathan <barryn@pobox.com>
