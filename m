Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTLXV4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTLXV4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:56:11 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:58119 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263909AbTLXV4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:56:10 -0500
Date: Wed, 24 Dec 2003 22:57:07 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, second wave
Message-Id: <20031224225707.749707e5.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be sending 5 patches to you, based on linux-2.4.24-pre2. They
contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
CVS repository [1].

Details about what the patch does and credits will be found with each
patch.

Please apply,
thanks.

[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
