Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270299AbRIEE7b>; Wed, 5 Sep 2001 00:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270973AbRIEE7V>; Wed, 5 Sep 2001 00:59:21 -0400
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:25544 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270299AbRIEE7K>; Wed, 5 Sep 2001 00:59:10 -0400
From: "Kevin D. Wooten" <kwooten@home.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Sending Signals
Date: Tue, 4 Sep 2001 22:00:14 -0700
Message-ID: <AEEEJLJGDLODKEHHFIABGEELCFAA.kwooten@home.com>
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

After looking through the source it looks to me like signals are sent while
a task is being rescheduled? If not, how and when are they sent?
My goal is to call a function registered with my driver, but I need a return
value from the function.

-kw

