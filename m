Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVKUXYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVKUXYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKUXYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:24:01 -0500
Received: from mail.gmx.de ([213.165.64.20]:51861 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964774AbVKUXYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:24:00 -0500
X-Authenticated: #342784
From: Jens-Michael Hoffmann <jensmh@gmx.de>
Organization: Hoffmann Information Services GmbH
To: linux-kernel@vger.kernel.org
Subject: white space fixes wanted?
Date: Tue, 22 Nov 2005 00:24:08 +0000
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511220024.11046.jensmh@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When looking in drivers/ieee1394/pcilynx.c, I noticed that there are a lot of spaces instead of tabs.
I prepared a patch to fix that.

file size of pcilynx.c before: 53775 bytes
file size after:                         42870 bytes

patch size is 85356 bytes.

Should I send this patch to the mailing list?

Jens-Michael
