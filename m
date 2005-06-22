Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262811AbVFVGSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbVFVGSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVFVGQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:16:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:46748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262813AbVFVFWM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:12 -0400
Cc: tklauser@nuerscht.ch
Subject: [PATCH] I2C: Spelling fixes for drivers/i2c/busses/i2c-parport.c
In-Reply-To: <11194174652306@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:45 -0700
Message-Id: <1119417465101@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Spelling fixes for drivers/i2c/busses/i2c-parport.c

This patch fixes a double "the" in a comment section.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 614e24be139c0ae70378349e6c6f0e21751e56bf
tree a2aec8b80eac393adb7b44baf0b875b802d496b7
parent 46b615f453202dbcf66452b500ab69c0e2148593
author Tobias Klauser <tklauser@nuerscht.ch> Thu, 19 May 2005 21:39:06 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:00 -0700

 drivers/i2c/busses/i2c-parport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -130,7 +130,7 @@ static int parport_getsda(void *data)
 /* Encapsulate the functions above in the correct structure.
    Note that this is only a template, from which the real structures are
    copied. The attaching code will set getscl to NULL for adapters that
-   cannot read SCL back, and will also make the the data field point to
+   cannot read SCL back, and will also make the data field point to
    the parallel port structure. */
 static struct i2c_algo_bit_data parport_algo_data = {
 	.setsda		= parport_setsda,

