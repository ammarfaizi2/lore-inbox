Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275432AbTHIWSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275433AbTHIWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:18:20 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:1037 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S275432AbTHIWSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:18:18 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: new dev_t printable convention and lilo
Date: Sun, 10 Aug 2003 02:18:51 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308100218.51271.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{pts/2}% cat /proc/cmdline
BOOT_IMAGE=260-t3smp2 ro root=345 devfs=mount

I guess it has to use 03:45 now? Does it mean lilo has to be updated to handle 
new convention?

-andrey
