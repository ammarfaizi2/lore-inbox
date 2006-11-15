Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161401AbWKOUuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161401AbWKOUuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030998AbWKOUuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:50:12 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34712 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030995AbWKOUuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:50:08 -0500
Message-ID: <455B7D7E.2030400@garzik.org>
Date: Wed, 15 Nov 2006 15:50:06 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Promise SATA vendor drivers uploaded
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To further assist anyone wishing to hack on sata_promise.c, I just 
uploaded the long-since-GPL'd vendor drivers for Generation-I and 
Generation-II chipsets to http://gkernel.sourceforge.net/specs/promise/

This should help with isolating the proper initialization sequence for a 
given set of chips, particularly.

If someone knows of updated versions of these GPL'd drivers, please let 
me know.

	Jeff


