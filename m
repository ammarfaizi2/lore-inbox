Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUI0Ht2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUI0Ht2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 03:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUI0Ht2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 03:49:28 -0400
Received: from mail1.kontent.de ([81.88.34.36]:26035 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266218AbUI0Ht1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 03:49:27 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 09:47:51 +0200
User-Agent: KMail/1.6.2
Cc: "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD5791@pdsmsx403>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409270947.52004.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. September 2004 05:43 schrieb Zhu, Yi:
> Oliver Neukum wrote:
> > Am Freitag, 24. September 2004 08:16 schrieb Zhu, Yi:
> >> Choice 3? or I missed something here?
> > 
> > If the user requests suspension, why can't he transfer the
> > firmware before he does so? Thus the firmware would be in ram
> > or part of the image read back from disk.
> 
> Do you suggest before user echo 4 > /proc/acpi/sleep, [s]he must
> do something like cat /path/of/firmware > /proc/net/ipw2100/firmware?

Yes.

	Regards
		Oliver
