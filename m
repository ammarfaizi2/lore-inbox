Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289715AbSAOWZy>; Tue, 15 Jan 2002 17:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSAOWZp>; Tue, 15 Jan 2002 17:25:45 -0500
Received: from mail.cdlsystems.com ([207.228.116.20]:53774 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S289775AbSAOWZg>;
	Tue, 15 Jan 2002 17:25:36 -0500
Message-ID: <042f01c19e13$6da6f4f0$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201151409270.1744-100000@barbarella.hawaga.org.uk>
Subject: Measuring execution time
Date: Tue, 15 Jan 2002 15:24:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm not sure if this is the place to ask this particular question - if not,
my apologies ....

I am working on optimizing some software and would like to be able to
measure how long an instruction takes (down to the clock cycle of the CPU).
I recall reading somewhere about a kernel time measurement called a "Jiffy"
and figured that it would probably apply to this.

If anyone has any tips on how to figure out how to do this I'd really
appreciate it.

Thanks!

Mark



