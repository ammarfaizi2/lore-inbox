Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUFSU5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUFSU5l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUFSU5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:57:41 -0400
Received: from mail.xor.ch ([212.55.210.163]:34579 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S264685AbUFSU5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:57:40 -0400
Message-ID: <40D4A8BF.DFDB48AC@orpatec.ch>
Date: Sat, 19 Jun 2004 22:57:36 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: How to check for the framebuffer device and the right kernel module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a simple app which checks if the framebuffer device is
correct installed (see
"http://wyodesktop.sourceforge.net/index.php?page=checkapp.html"). I do
it by more less just using the device. My little check app is working
but shouldn't there be a more correct way?

I'm also not sure what results are produced when the device exists but
without the right kernel module. How can I check for a kernel module to
inform the user about it?

O. Wyss

PS. I welcome any feedback (e-mail) how this little app behaves on
anyones system.

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"
