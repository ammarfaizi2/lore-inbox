Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDETaW (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 14:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTDETaW (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 14:30:22 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:41365 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262627AbTDETaW (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 14:30:22 -0500
Date: Sat, 5 Apr 2003 14:37:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: does video for linux depend on I2C?
Message-ID: <Pine.LNX.4.44.0304051436340.20539-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 the help screen for I2C support claims that you need
I2C for video for linux support.  however, it's still
possible to not select I2C and yet select video for
linux.

  is there a Kconfig dependency missing here?

rday

