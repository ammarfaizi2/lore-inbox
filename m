Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUAKNkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUAKNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:40:24 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:19721 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264446AbUAKNkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:40:22 -0500
Date: Sun, 11 Jan 2004 14:42:14 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups, third wave
Message-Id: <20040111144214.7a6a4e59.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
CVS repository [1]. Since that repository was also the base of the i2c
subsystem as is now in linux 2.6, one might also consider these patches
as backports from linux 2.6.

Details about what the patch does and credits will be found with each
patch.

Please apply,
thanks.

[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
