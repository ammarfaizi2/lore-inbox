Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUFNWu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUFNWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUFNWu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:50:58 -0400
Received: from smtp.infonegocio.com ([213.4.129.150]:750 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S263850AbUFNWu5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:50:57 -0400
Subject: pdc202xx_old serious bug with DMA on 2.6.x series
From: Adolfo =?ISO-8859-1?Q?Gonz=E1lez_Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1087253451.4817.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 00:50:52 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Lot of users are reporting seriour problems with pdc202xx_old ide pci
driver. Enabling DMA on any device related with this driver makes the
system unusable. 

This seems to happen in all the 2.6.x kernel series.

More info on Kerneltrap: http://kerneltrap.org/node/view/3040
More info on Bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=2494

I hope someone can fix this, 'cause there's a lot of people using these
ide controllers.

Adolfo González

