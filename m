Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSIWVAS>; Mon, 23 Sep 2002 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSIWVAS>; Mon, 23 Sep 2002 17:00:18 -0400
Received: from web14502.mail.yahoo.com ([216.136.224.65]:10415 "HELO
	web14502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261387AbSIWVAR>; Mon, 23 Sep 2002 17:00:17 -0400
Message-ID: <20020923210529.95986.qmail@web14502.mail.yahoo.com>
Date: Mon, 23 Sep 2002 14:05:29 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: 2.4.20-pre7 + tulip (CONEXANT) breaks under load
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

The CONEXANT tulip driver present since 2.4.20-pre2
breaks even with moderate load. Presario 1700T.
kernel: NETDEV WATCHDOG: eth0: transmit timed out

The driver at scyld also breaks for me but only under
much heavier stress.

Please CC.

Kent

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
