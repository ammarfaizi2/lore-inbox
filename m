Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSCFOPg>; Wed, 6 Mar 2002 09:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293595AbSCFOPZ>; Wed, 6 Mar 2002 09:15:25 -0500
Received: from mail009.syd.optusnet.com.au ([203.2.75.170]:57832 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S293583AbSCFOPP>; Wed, 6 Mar 2002 09:15:15 -0500
Message-ID: <007501c1c519$fe289010$0901010a@C5043436>
From: "Ronnie Sahlberg" <sahlberg@optushome.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.6-pre2 IDE cleanup 16
Date: Thu, 7 Mar 2002 00:46:52 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>MD> 2. It convinced me that the current task-file interface in linux
>MD> is inadequate. So Alan please bear with me if your CF format
>MD> microdrive will have to not wakeup properly for some time...
>MD> The current mess will just have to go before something more
>MD> adequate can go in.
>
>Why not keep the existing taskfile implementation in until you complete the
>elegant implementation?

seriously, ide has always been a joke for anyone serious in storage capacity
or robustness. so what.

if you were serious in using ide drives you would have been using external
patches for quite a while anyway. nothings changed.
Well, nothing, except that now, that there will be a much higher percentage
of users that relies on external patches for ide to be useful
or work at all

time for someone actually has a clue on how modern ide drives works to have
a say for a change...?


