Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271863AbRIDAma>; Mon, 3 Sep 2001 20:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271867AbRIDAmV>; Mon, 3 Sep 2001 20:42:21 -0400
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:8378 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271863AbRIDAmK>; Mon, 3 Sep 2001 20:42:10 -0400
From: "Kevin D. Wooten" <kwooten@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: Calling user-space code from within module?
Date: Mon, 3 Sep 2001 17:43:19 -0700
Message-ID: <AEEEJLJGDLODKEHHFIABMECPCFAA.kwooten@home.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to call a user-space function from within a kernel module,
providing at some point a function pointer was passed in? If so how would
you call this function if you were in the context of another process?

-kw

