Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279561AbRJXNIj>; Wed, 24 Oct 2001 09:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279559AbRJXNI3>; Wed, 24 Oct 2001 09:08:29 -0400
Received: from samar.sasken.com ([164.164.56.2]:47582 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S279561AbRJXNIK>;
	Wed, 24 Oct 2001 09:08:10 -0400
From: "Shiva Raman Pandey" <shiva@sasken.com>
Subject: Netfilter Question
Date: Wed, 24 Oct 2001 18:39:55 +0530
Message-ID: <9r6ego$bfr$1@ncc-z.sasken.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Friends,
When I get a packet using netfilter/iptables, I want to send it twice.
I mean I want to call set_verdict function twice.
Is it possible?
Is there any method to achieve this?
Do I have to play around packet_id and data_len parameters?
will handle create any problem?

Regards
Shiva


