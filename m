Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUASXzt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUASXzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:55:49 -0500
Received: from ktown.kde.org ([131.246.103.200]:50599 "EHLO dot.kde.org")
	by vger.kernel.org with ESMTP id S263723AbUASXzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:55:46 -0500
Date: Mon, 19 Jan 2004 23:48:34 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@arklinux.org>
X-X-Sender: bero@dot.kde.org
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] [2.6.1-mm4] RAID6 doesn't build on x86_64
Message-ID: <Pine.LNX.4.58.0401192347230.17935@dot.kde.org>
X-Legal-Notice: We do not accept spam. Violations will be prosecuted.
X-Subliminal-Message: Upgrade your system to Ark Linux today! http://www.arklinux.org/
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658386544-2107232143-1074552481=:17935"
Content-ID: <Pine.LNX.4.58.0401192348320.17935@dot.kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--658386544-2107232143-1074552481=:17935
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0401192348321.17935@dot.kde.org>

Trivial fix attached

LLaP
bero

-- 
Ark Linux - Linux for the masses
http://www.arklinux.org/

Redistribution and processing of this message is subject to
http://www.arklinux.org/terms.php
--658386544-2107232143-1074552481=:17935
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="raid6-x86_64.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0401192348010.17935@dot.kde.org>
Content-Description: fix
Content-Disposition: ATTACHMENT; FILENAME="raid6-x86_64.patch"

LS0tIGxpbnV4LTIuNi4xL2RyaXZlcnMvbWQvcmFpZDZhbGdvcy5jLmFyawky
MDA0LTAxLTIwIDA3OjU5OjE5LjAwODg0OTAwOCArMDEwMA0KKysrIGxpbnV4
LTIuNi4xL2RyaXZlcnMvbWQvcmFpZDZhbGdvcy5jCTIwMDQtMDEtMjAgMDc6
NTk6MjIuMzY0MzM4ODk2ICswMTAwDQpAQCAtNTUsNyArNTUsNyBAQA0KIAkm
cmFpZDZfc3NlMngyLA0KICNlbmRpZg0KICNpZiBkZWZpbmVkKF9feDg2XzY0
X18pDQotCSZyYWlkNl9zc2UyeDQ7DQorCSZyYWlkNl9zc2UyeDQsDQogI2Vu
ZGlmDQogCU5VTEwNCiB9Ow0K

--658386544-2107232143-1074552481=:17935--
