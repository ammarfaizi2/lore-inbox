Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVGZU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVGZU6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVGZU5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:57:55 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:5033 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262022AbVGZU5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:57:42 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: [ACPI] Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
Date: Tue, 26 Jul 2005 23:02:36 +0200
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
References: <200507261247.05684.rjw@sisk.pl> <200507261254.05507.rjw@sisk.pl> <42E62BB0.6010409@gmx.net>
In-Reply-To: <42E62BB0.6010409@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507262302.37488.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 of July 2005 14:25, Carl-Daniel Hailfinger wrote:
> Rafael J. Wysocki schrieb:
> > The following patch adds basic suspend/resume support to the sk98lin
> > network driver.
> [snipped]
> 
> The current in-kernel sk98lin driver is years behind the version
> downloadable from Syskonnect. Maybe it would make sense to update
> it first before applying any new patches.
> http://www.syskonnect.com/support/driver/d0102_driver.html

You are right, but I don't know who should do this.  I have only submitted
the patch to eliminate a problem with the current kernel.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
