Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbSLLAdI>; Wed, 11 Dec 2002 19:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSLLAdH>; Wed, 11 Dec 2002 19:33:07 -0500
Received: from fmr01.intel.com ([192.55.52.18]:16628 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267332AbSLLAdG>;
	Wed, 11 Dec 2002 19:33:06 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E3A0@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "Lmkl (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: RE: Slow SCSI AIC7xxx on 2.5.48
Date: Wed, 11 Dec 2002 16:40:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On other thing I forgot to mention.  Uptime would show (after 30 or 40 secs
of waiting for it to return) that system load was > .80 even though no major
apps were running (no X or anything else).

--
Tariq Shureih
Intel Corporation
Opinions are my own and don't represent my emplyer

-----Original Message-----
From: Shureih, Tariq [mailto:tariq.shureih@intel.com] 
Sent: Wednesday, December 11, 2002 4:03 PM
To: Lmkl (linux-kernel@vger.kernel.org)
Subject: Slow SCSI AIC7xxx on 2.5.48

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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
