Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBMJjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBMJjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 04:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVBMJjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 04:39:54 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:7434 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261257AbVBMJjw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 04:39:52 -0500
Date: Sun, 13 Feb 2005 10:40:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Enable I2C_PIIX4 for 64-bit platforms
Message-Id: <20050213104014.07fef9a8.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61L.0502120502580.30117@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61L.0502120502580.30117@blysk.ds.pg.gda.pl>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

> Is there any specific reason for the PIIX4 SMBus driver to be
> disabled on 64-bit platforms?

No idea.

> If not, then please apply the following change. 
> The MIPS Technologies Malta development board has the 82371EB chip
> and supports 64-bit configurations.  I've verified the driver to
> work correctly using 64-bit kernels for both endiannesses.

Fine with me.

-- 
Jean Delvare
