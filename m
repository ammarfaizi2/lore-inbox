Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRDUUzK>; Sat, 21 Apr 2001 16:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132770AbRDUUzC>; Sat, 21 Apr 2001 16:55:02 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:56250 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S132583AbRDUUyn>;
	Sat, 21 Apr 2001 16:54:43 -0400
Date: Sat, 21 Apr 2001 22:54:41 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: <linux-kernel@vger.kernel.org>
Subject: XFree4/gdm problems with 2.4.4-pre5
Message-ID: <Pine.GSO.4.32.0104212250410.29571-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest XFree4 (4.0.99.33 current cvs snapshot) and gdm
2.0-0.beta4-helix12 have problems with kernel 2.4.4-pre5. gdm has been
the same version for long time, kerne and XFree have changed almost
together. After logging the user out, no new gdm login appears. Tracing
then is hard because ptraced x server runs very slowly. It may be either
XFree or kernel.

---
Meelis Roos (mroos@linux.ee)

