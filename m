Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTEVXFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTEVXFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:05:37 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:59554 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263452AbTEVXFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:05:35 -0400
Subject: irtty_sir cannot be unloaded
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1053645572.760.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 23 May 2003 01:19:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get this message when trying to use irda with 2.5.x. I know it has
been there for a long time, but since nothing happens, I wonder if
anyone knows about it? I don't really need to unload it, but when I
reboots (or shutdowns) my pc, it hangs at "deconfiguring network
interfaces". Which is quite annoying. I guess I can change my
init-scripts to now do that, but...

Module irtty_sir cannot be unloaded due to unsafe usage in
include/linux/module.h:456

Best regards,
Stian

