Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUC1A5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUC1A5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:57:13 -0500
Received: from mxsf02.cluster1.charter.net ([209.225.28.202]:6153 "EHLO
	mxsf02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262041AbUC1A5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:57:12 -0500
Subject: 2.6.5-rc2-mm[34] causes drop in DRI FPS
From: Glenn Johnson <glennpj@charter.net>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080435375.8280.1.camel@gforce.johnson.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 27 Mar 2004 18:56:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last two iterations of -mm kernels have caused my FPS count via
glxgears to drop from about 2000 fps to about 180 fps. I rebuilt X11 to
see if that would help but it did not.

This is with a Radeon 9100 AGP card and an Intel 865PE based
motherboard.


