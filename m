Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbTLMSMb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbTLMSMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:12:31 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:46863 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S265243AbTLMSMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:12:30 -0500
Date: Sat, 13 Dec 2003 19:12:58 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031213191258.2d78a9f7.khali@linux-fr.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I will be sending 4 patches to you, based on linux-2.4.24-pre1. They
contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
CVS repository [1].

Details about what the patch do will be found with each patch.

Thanks.

[1] http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/i2c

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
