Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSLZGEz>; Thu, 26 Dec 2002 01:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSLZGEz>; Thu, 26 Dec 2002 01:04:55 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:40543 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S262430AbSLZGEy>; Thu, 26 Dec 2002 01:04:54 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Josh Brooks'" <user@mail.econolodgetulsa.com>,
       "'Billy Rose'" <billyrose@billyrose.net>
Cc: <bp@dynastytech.com>, <linux-kernel@vger.kernel.org>,
       <felipewd@terra.com.br>
Subject: RE: CPU failures ... or something else ?
Date: Thu, 26 Dec 2002 00:13:07 -0600
Message-ID: <001d01c2aca5$dd35ff40$b9293a41@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021225200357.U6873-100000@mail.econolodgetulsa.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> usually it says proc #1 in the error, but
> the first time it said proc #0 - is that
> interesting ?

proc 0 and proc 1 are CPU 0 and CPU 1, respectively.  If you switched CPU's
and now the error is on the other proc, then it IS a CPU error.

Joseph Wagner

P.S.  In hindsight, I probably should have read the entire thread before
responding.  8-)  You live you learn.

Joseph Wagner

