Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbTENIbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTENIbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:31:22 -0400
Received: from [62.39.112.246] ([62.39.112.246]:22743 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S261261AbTENIbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:31:20 -0400
Date: Wed, 14 May 2003 10:44:04 +0200 (CEST)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.69] Make xconfig compile with gcc 3.3
Message-ID: <Pine.LNX.4.53.0305141043480.25628@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="658437744-961343748-1052901793=:25628"
Content-ID: <Pine.LNX.4.53.0305141043481.25628@dot.kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658437744-961343748-1052901793=:25628
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0305141043482.25628@dot.kde.org>

make xconfig doesn't work with the soon to be released gcc 3.3.
The attached patch fixes it.

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658437744-961343748-1052901793=:25628
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="linux-2.5.69-xconfig-gcc-3.3.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305141043130.25628@dot.kde.org>
Content-Description: patch
Content-Disposition: ATTACHMENT; FILENAME="linux-2.5.69-xconfig-gcc-3.3.patch"

LS0tIGxpbnV4LTIuNS42OS9zY3JpcHRzL2tjb25maWcvcWNvbmYuY2MuYXJr
CTIwMDMtMDUtMTQgMTA6MTg6NTkuMDAwMDAwMDAwICswMjAwDQorKysgbGlu
dXgtMi41LjY5L3NjcmlwdHMva2NvbmZpZy9xY29uZi5jYwkyMDAzLTA1LTE0
IDEwOjE5OjM1LjAwMDAwMDAwMCArMDIwMA0KQEAgLTI4OCw3ICsyODgsOCBA
QA0KIENvbmZpZ0l0ZW06On5Db25maWdJdGVtKHZvaWQpDQogew0KIAlpZiAo
bWVudSkgew0KLQkJQ29uZmlnSXRlbSoqIGlwID0gJihDb25maWdJdGVtKilt
ZW51LT5kYXRhOw0KKwkJQ29uZmlnSXRlbSogaT0oQ29uZmlnSXRlbSopbWVu
dS0+ZGF0YTsNCisJCUNvbmZpZ0l0ZW0qKiBpcCA9ICZpOw0KIAkJZm9yICg7
ICppcDsgaXAgPSAmKCppcCktPm5leHRJdGVtKSB7DQogCQkJaWYgKCppcCA9
PSB0aGlzKSB7DQogCQkJCSppcCA9IG5leHRJdGVtOw0K

--658437744-961343748-1052901793=:25628--
