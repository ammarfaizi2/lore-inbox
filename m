Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTJRXKA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTJRXKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:10:00 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:1943 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261923AbTJRXJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:09:59 -0400
Subject: kernel-2.6.0-test{7-8} and radeon drm segfault
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066518605.4195.11.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Sat, 18 Oct 2003 19:10:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with kernel-2.6 on redhat's latest beta. With my
radeon 7500 drm works great. When I boot to kernel-2.6 latest, I
modprobe agpgart, intel-agp and radeon. Startx and run glxinfo
and glxgears and both segfault. Anyone else seeing this? This
also happens if these are build statically.

--Lou

