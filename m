Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbUJYMdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUJYMdR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUJYMdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:33:17 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:51155 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261775AbUJYMdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:33:12 -0400
Date: Mon, 25 Oct 2004 14:32:55 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: usb hotplug \$DEVICE empty
Message-ID: <20041025123255.GA1435@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: TD9M0vZUYe+RaOwqbfXvbUfU253Sk644117I+wm4V6OnO2fFoTanY8
X-TOI-MSGID: c49ff771-0363-4951-983f-f186bd8cad4a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.10-rc1-bk2 my hotplug script does not get the
usb-device via $DEVICE any more. 

(Yes, I have CONFIG_USB_DEVICEFS=y in .config)

Other information like ACTION PRODUCT .. is still passed.

The last kernel (I have here) which worked in this respect 
is 2.6.9-rc4-bk7.

--
Klaus
