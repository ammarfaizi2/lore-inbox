Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276461AbRI2Iqp>; Sat, 29 Sep 2001 04:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276462AbRI2Iqf>; Sat, 29 Sep 2001 04:46:35 -0400
Received: from smtp1.vol.cz ([195.250.128.43]:27151 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S276461AbRI2IqZ>;
	Sat, 29 Sep 2001 04:46:25 -0400
Message-ID: <001b01c148c3$435151f0$13a76cc0@NEVSKIJ>
From: "Petr Titera" <owl@volny.cz>
To: <nerijus@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
Date: Sat, 29 Sep 2001 10:41:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mount with showexec option helps a lot (at least on recent -ac series). With
this option only files executable in Windows environment are marked as
executable.

Petr

