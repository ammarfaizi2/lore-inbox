Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315389AbSDWXod>; Tue, 23 Apr 2002 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315390AbSDWXod>; Tue, 23 Apr 2002 19:44:33 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:61125 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S315389AbSDWXoc>;
	Tue, 23 Apr 2002 19:44:32 -0400
Message-ID: <028c01c1eb20$d9c6cd90$a764a8c0@tdnlaptop>
From: "Reid Sutherland" <reid@vianet.ca>
To: <linux-kernel@vger.kernel.org>
Subject: BUG 2.4.19-pre7: Console on serial interface not working.
Date: Tue, 23 Apr 2002 19:44:46 -0400
Organization: ViaNet Communications Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The enable console on a serial interface no longer works.  Works fine in
<2.4.18.

I have no other details.  I didn't do extensive testing, just switched
kernels, and it failed.

Thanks,

-reid

