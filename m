Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUFNQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUFNQpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUFNQpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:45:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:13242 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263375AbUFNQpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:45:42 -0400
X-Authenticated: #279318
Message-ID: <40CDD63C.BFF115C4@gmx.de>
Date: Mon, 14 Jun 2004 18:45:48 +0200
From: Genesis1976@gmx.de
X-Mailer: Mozilla 4.78 [de]C-CCK-MCD DT  (Windows NT 5.0; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel make menuconfig
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I some make menuconfig Problems within kernel 2.6.6.

When I unpack a freshly downloaded kernel e.g. the Options Mouse
Interface and Provide Legacy /dev/psaux device are missing. When I copy
the debian kernel-config-file into /usr/src/linux/.config the options
are suddenly there.

That puzzles me a bit because I can't get my PS2-mouse working on that
particular machine (AT-mainboard; Gigabyte GA-6BA).

Cheers,
Martin

