Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSDXFFG>; Wed, 24 Apr 2002 01:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314512AbSDXFFF>; Wed, 24 Apr 2002 01:05:05 -0400
Received: from smtp.wp.pl ([212.77.101.161]:4405 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id <S311650AbSDXFFE>;
	Wed, 24 Apr 2002 01:05:04 -0400
Message-ID: <002401c1eb4d$a75a32c0$a0d84dd5@q5s4z1>
From: "Jarek Pelczar" <jarekp3@wp.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Re:  Why HZ on i386 is 100
Date: Wed, 24 Apr 2002 07:05:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to recompile kernel without changing timer freq to 100Hz. See the
diffrence :)


