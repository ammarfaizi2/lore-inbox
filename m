Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268316AbRG0S3o>; Fri, 27 Jul 2001 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268335AbRG0S3f>; Fri, 27 Jul 2001 14:29:35 -0400
Received: from oe53.law12.hotmail.com ([64.4.18.46]:49938 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S268316AbRG0S3T>;
	Fri, 27 Jul 2001 14:29:19 -0400
X-Originating-IP: [200.42.64.49]
From: "Sergio A. Kessler" <sergio_kessler@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Flags; bus-master 1, dirty [...]
Date: Fri, 27 Jul 2001 15:28:44 -0300
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <OE53F8HGmCvoXM7e0C9000044da@hotmail.com>
X-OriginalArrivalTime: 27 Jul 2001 18:29:21.0518 (UTC) FILETIME=[0DE1A0E0:01C116CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hi,

I'm getting this at the screen at /var/log/messages

what's going on ?   something bad ?
(kernel-2.4.3-12, mother intel D815EEA2, PIII933)

Jul 27 14:56:50 safari kernel:   Flags; bus-master 1, dirty 163181(13)
current 163181(13)
Jul 27 14:56:50 safari kernel:   Transmit list 00000000 vs. cf0d9540.
Jul 27 14:56:50 safari kernel:   0: @cf0d9200  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   1: @cf0d9240  length 80000536 status
00010536
Jul 27 14:56:50 safari kernel:   2: @cf0d9280  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   3: @cf0d92c0  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   4: @cf0d9300  length 80000536 status
00010536
Jul 27 14:56:50 safari kernel:   5: @cf0d9340  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   6: @cf0d9380  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   7: @cf0d93c0  length 80000536 status
00010536
Jul 27 14:56:50 safari kernel:   8: @cf0d9400  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   9: @cf0d9440  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   10: @cf0d9480  length 80000536 status
00010536
Jul 27 14:56:50 safari kernel:   11: @cf0d94c0  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   12: @cf0d9500  length 800005ba status
800105ba
Jul 27 14:56:50 safari kernel:   13: @cf0d9540  length 800005ba status
000105ba
Jul 27 14:56:50 safari kernel:   14: @cf0d9580  length 80000084 status
00010084
Jul 27 14:56:50 safari kernel:   15: @cf0d95c0  length 800005ba status
000105ba


