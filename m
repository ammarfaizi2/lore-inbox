Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWJVTWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWJVTWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWJVTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:22:51 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:42121 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750932AbWJVTWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:22:51 -0400
Date: Sun, 22 Oct 2006 21:22:06 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "S.Mohideen" <moin@blackhole.labs.rootshell.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: Moving to 2.6
In-Reply-To: <1161522280.2035.0.camel@libranet-box>
Message-ID: <Pine.LNX.4.61.0610222121330.22903@yvahk01.tjqt.qr>
References: <1161519502.1946.3.camel@libranet-box> <1161522280.2035.0.camel@libranet-box>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Done !! It worked after installing new set modutils from kernel.org.

I am sure Documentation/ would have told you:


21:22 ichi:../linux/Documentation > grep module-init-t * -n
Changes:35:o  module-init-tools      0.9.10                  # depmod -V
Changes:115:A new module loader is now in the kernel that requires 
module-init-tools



>Previously, I was receiving QM_MODULES errors..
>

	-`J'
-- 
