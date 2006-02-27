Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWB0Oik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWB0Oik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWB0Oik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:38:40 -0500
Received: from s93.xrea.com ([218.216.67.44]:975 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S1751263AbWB0Oik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:38:40 -0500
Message-Id: <200602271438.AA00697@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Mon, 27 Feb 2006 23:38:28 +0900
To: linux-kernel@vger.kernel.org
Subject: MACH BOOT
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We introduce here that MACH BOOT, which is an experimental CD booting technology
with the goal of achieving fast booting with x48 CD-ROM drive.

Check this out, please.
http://www.machboot.com/


Features:

    1.  Booting fast, usually within 10 secs from x48 CD-ROM drive.
    2.  Launching apps is also fast. Almost same as from HDD.
    3.  Customizable. You can make it "MACH" with any distribution,
        including your original one.
    4.  (Hopefully) Better PnP than KNOPPIX.
        This feature is not sure for now --- I just have tested on only a few PCs.


Credits:

Concept and Programming :  Okajima, Jun.
Special Thanks : All people of LazyFS and tmpfs, Especially Dr. Thomas Leonard.


                 --- Okajima, Jun. Tokyo, Japan.
                        President, Digital Infra, Inc.
                        http://www.digitalinfra.co.jp/
                        http://www.colinux.org/
                        http://www.machboot.com/


