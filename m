Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUFVTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUFVTin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUFVTep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:34:45 -0400
Received: from mail.xor.ch ([212.55.210.163]:56592 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S265476AbUFVTco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:32:44 -0400
Message-ID: <40D88952.43EAB6BC@orpatec.ch>
Date: Tue, 22 Jun 2004 21:32:35 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: How to check for the framebuffer device and the                        
 right kernel module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've written a simple app which checks if the framebuffer device is
correct installed. I do
it by more less just using the device. My little check app is working
but shouldn't there be a more correct way?

I'm also not sure what results are produced when the device exists but
without the right kernel module. How can I check for a kernel module to
inform the user about it?

O. Wyss
