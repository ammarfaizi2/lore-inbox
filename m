Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270103AbTGVHQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270139AbTGVHQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:16:14 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:62870 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S270103AbTGVHQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:16:13 -0400
Date: Tue, 22 Jul 2003 10:31:15 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
Subject: USB flash disk on 2 machines exclusiv
Message-ID: <Pine.LNX.4.53.0307221026120.2214@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg, list!

Sorry for my english.

I have a usb flash disk (Butterfly, I think).
Also, I have 2 machines, Athlons, 2.4.22pre7 and 2.4.22pre3.

The disk is recognized by both machines as sda1.

I do a mkreiserfs /dev/sda1, mount it and everything works on machine 1.
If I go to machine 2, the kernel cannot recognise a valid reiserfs on the
flash. If I do a mkreiserfs, I can work with it, but when I move to
machine 1, same problem (reiserfs not recognized).

Any ideas?

Thank you very much.

---
Catalin(ux) BOIE
catab@deuroconsult.ro
