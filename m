Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbULRN4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbULRN4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 08:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbULRN4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 08:56:23 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:60139 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261197AbULRN4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 08:56:19 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: usbdevfs mount failure with 2.6.10-rc3
Date: Sat, 18 Dec 2004 13:34:42 GMT
Message-ID: <04I4WDU12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.10-rc3 I get ENODEV error when trying to mount usbdevfs
No problem with 2.6.9
