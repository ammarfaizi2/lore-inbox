Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbRE2FCf>; Tue, 29 May 2001 01:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263217AbRE2FCY>; Tue, 29 May 2001 01:02:24 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:50133 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263213AbRE2FCN>; Tue, 29 May 2001 01:02:13 -0400
Subject: via-rhine
From: Daniel Rose <daniel.rose@datalinesolutions.com>
To: linux-kernel@vger.kernel.org, baker@scyld.com
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 29 May 2001 01:01:07 -0400
Message-Id: <991112468.923.1.camel@rocket>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding previous posts i've made on this subject, it turns out that
using a card with this chipset (i assume all cards - i've only tried a
DFE-530TX) will only reset on a cold boot, and are upset when booted to
windows (it causes them to not respond in linux) A cold boot fixes the
problem. I'm not sure if this chipset is able to be reset "on the fly"
but I sure am interested..

Daniel

