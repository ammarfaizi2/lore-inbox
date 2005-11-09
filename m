Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVKIWap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVKIWap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbVKIWao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:30:44 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:32986 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750971AbVKIWao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:30:44 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] fix for Toshiba ohci1394 quirk
Date: Wed, 9 Nov 2005 14:30:20 -0800
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>
References: <200511082013.02627.jbarnes@virtuousgeek.org>
In-Reply-To: <200511082013.02627.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511091430.21176.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, can you be sure this fix makes it upstream for 2.6.15?

With this patch applied, this laptop (a Toshiba Satellite M45 class box) 
and Linux get along pretty well.  All the hardware, save the TI SD chip, 
is supported by Linux drivers (i9xx for graphics, ipw2200 wireless, sky2 
ethernet, etc.).  I'm pretty happy with it.

Thanks,
Jesse
