Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTADWDF>; Sat, 4 Jan 2003 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTADWDF>; Sat, 4 Jan 2003 17:03:05 -0500
Received: from smtp.comcast.net ([24.153.64.2]:5370 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261338AbTADWDE>;
	Sat, 4 Jan 2003 17:03:04 -0500
Date: Sat, 04 Jan 2003 17:23:55 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Tryint to enable support for lm_sensors
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1041719036.2877.3.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What options (int make xconfig) do I have to enable to get the i2c-via
and i2c-viapro modules to build .  I realized that the kernels and
modules that Redhat provided included these two modules, but when I
built a 2.4.20 kernel (downloaded from kernel.org) those modules were
not built.  I chose support for i2c as a module and the i2c-proc and
i2c-core modules were built just fine.  What am I missing?

Josh


