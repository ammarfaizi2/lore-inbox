Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132670AbRDKUCA>; Wed, 11 Apr 2001 16:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132681AbRDKUBu>; Wed, 11 Apr 2001 16:01:50 -0400
Received: from colorfullife.com ([216.156.138.34]:50703 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132670AbRDKUBd>;
	Wed, 11 Apr 2001 16:01:33 -0400
Message-ID: <001801c0c2c2$489f3050$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <Imran.Patel@nokia.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: skb allocation problems (More Brain damage!)
Date: Wed, 11 Apr 2001 22:02:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it is very hard to imagine the scenario which can lead to this...
> I will try your suggestion..

Perhaps a problem with the csum assembler implementations? Which cpu
type do you optimize for, and which cpu is installed?

Btw, are you overclocking anything?

--
    Manfred




