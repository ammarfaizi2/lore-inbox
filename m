Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbSLKWis>; Wed, 11 Dec 2002 17:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbSLKWiT>; Wed, 11 Dec 2002 17:38:19 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10244 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267348AbSLKWhm>;
	Wed, 11 Dec 2002 17:37:42 -0500
Date: Wed, 11 Dec 2002 23:44:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: Confusing help texts?
Message-ID: <20021211224422.GA461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

+ * Prevents any programs running with egid == 0 if a specific USB device
+ * is not present in the system.  Yes, it can be gotten around, but is a
+ * nice starting point for people to play with, and learn the LSM
+ * interface.

How can you "prevent any program"?

+         It enables control over processes being created by root users
+         if a specific USB device is not present in the system.

Enables control over processes?

Confused,
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
