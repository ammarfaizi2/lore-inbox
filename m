Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbREQMOk>; Thu, 17 May 2001 08:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbREQMOa>; Thu, 17 May 2001 08:14:30 -0400
Received: from news.lucky.net ([193.193.193.102]:19728 "EHLO news.lucky.net")
	by vger.kernel.org with ESMTP id <S261406AbREQMOL>;
	Thu, 17 May 2001 08:14:11 -0400
From: "V.Kouzmin" <valery@legbank.kiev.ua>
To: linux-kernel@vger.kernel.org
Subject: Using CPIO ???
Date: Thu, 17 May 2001 15:05:50 +0300
Organization: Unknown
Message-ID: <9e0eos$fjd$1@news.lucky.net>
X-Trace: news.lucky.net 990101086 15981 193.193.193.191 (17 May 2001 12:04:46 GMT)
X-Complaints-To: usenet@news.lucky.net
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all!

Please,

tell me how to retrieve files from the tape after archieving

by such command:

ls | cpio -oc | gzip | dd bs=20k > /dev/rmt/0

Thanks for answering.

                                            Valery Kouzmin.

