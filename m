Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267369AbSLKXzM>; Wed, 11 Dec 2002 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLKXzL>; Wed, 11 Dec 2002 18:55:11 -0500
Received: from fmr01.intel.com ([192.55.52.18]:34768 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267369AbSLKXzK>;
	Wed, 11 Dec 2002 18:55:10 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E39A@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "Lmkl (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: Slow SCSI AIC7xxx on 2.5.48
Date: Wed, 11 Dec 2002 16:02:46 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone noticed some serious degradation in performance using AIC7xxx
driver in 2.5.48?

I have a system with Intel's SL2 dual PIII Xeon 933 with on board scsi
adaptec.

When I load the 2.4.19 kernel, everything is fine.

Using 2.5.48, when I login it takes it sometimes up to 1 minute 34 seconds
to return me a prompt and good luck with "ps".
No errors or messages though.

I have not tried it with 2.5.51 to see if anything changed. 

Is this known?

*_*_*_*_*_*
Tariq Shureih
*_*_*_*_*_*_*_*_*
Opinions are my own and don't represent my employer


