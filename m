Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTG0Sqg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 14:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbTG0Sqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 14:46:36 -0400
Received: from dialpool-210-214-82-62.maa.sify.net ([210.214.82.62]:27264 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270928AbTG0Sqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 14:46:36 -0400
Date: Mon, 28 Jul 2003 00:32:57 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 OSS emu10k1
Message-ID: <20030727190257.GA2840@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot compile the emu10k1 module:

sound/oss/emu10k1/hwaccess.c:182: redefinition of `emu10k1_writefn0_2'
sound/oss/emu10k1/hwaccess.c:164: `emu10k1_writefn0_2' previously defined here
make[3]: *** [sound/oss/emu10k1/hwaccess.o] Error 1
make[2]: *** [sound/oss/emu10k1] Error 2
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2


Everything else looks fine till now...
