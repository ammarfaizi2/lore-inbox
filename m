Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUIXQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUIXQBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268878AbUIXQBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:01:38 -0400
Received: from mail1.kontent.de ([81.88.34.36]:31886 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268873AbUIXQBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:01:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Zhu, Yi" <yi.zhu@intel.com>
Subject: Re: suspend/resume support for driver requires an external firmware
Date: Fri, 24 Sep 2004 18:00:51 +0200
User-Agent: KMail/1.6.2
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
In-Reply-To: <Pine.LNX.4.44.0409241405540.12384-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409241800.51507.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 08:16 schrieb Zhu, Yi:
> Choice 3? or I missed something here?

If the user requests suspension, why can't he transfer the firmware
before he does so? Thus the firmware would be in ram or part of
the image read back from disk.

	Regards
		Oliver
