Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbTLSCOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 21:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbTLSCOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 21:14:15 -0500
Received: from smtp04.web.de ([217.72.192.208]:39684 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265415AbTLSCOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 21:14:15 -0500
From: Steffen Schwientek <schwientek@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6-test11 framebuffer Matrox
Date: Fri, 19 Dec 2003 03:14:13 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312190314.13138.schwientek@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Matrox-framebuffer is not working properly. Build direct into the
kernel, the monitor will be black with some stripes at startup, just the
reset button works.
Build as a modules, the same happens if I load the module.

The make xconfig script also advice me to compile some 8,16,24 and 32 bpp
packed pixel too, but I cant find them in the 2.6 kernel configuration

Steffen
