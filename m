Return-Path: <linux-kernel-owner+w=401wt.eu-S1751051AbXALNGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbXALNGV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXALNGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:06:20 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:33555 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXALNGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:06:20 -0500
X-Greylist: delayed 1353 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 08:06:20 EST
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Kernel command line for a specific framebuffer console driver
Date: Fri, 12 Jan 2007 13:43:42 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121343.43100.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

does someone know how to forward a kernel command line option to configure the 
AMD Geode GX1 framebuffer?

I tried with "video=gx1fb:1024x768-16@60" but it does not work. On another 
machine with an SIS framebuffer the line "video=sisfb:1280x1024-8@60" works 
as expected.

Any ideas?

Juergen
