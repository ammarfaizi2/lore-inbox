Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273371AbRIWKk5>; Sun, 23 Sep 2001 06:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273372AbRIWKkq>; Sun, 23 Sep 2001 06:40:46 -0400
Received: from smtp2.vol.cz ([195.250.128.42]:15374 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S273371AbRIWKkk>;
	Sun, 23 Sep 2001 06:40:40 -0400
Message-ID: <000901c1441f$6f4d5ae0$12a76cc0@desktop>
From: =?iso-8859-2?Q?Petr_Tit=ECra?= <owl@volny.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Noexec flag in ac series
Date: Sun, 23 Sep 2001 13:03:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    can you someone pleas explain me what is behind a change of handling
noexec mount flag in recent ac series?
In Linus tree when VFAT filesystem is mounted with noexecall files except
directories have their exec flag cleared. In ac series is set. Files are not
runnable so internal handling of noexec is OK.


Petr

P.S.: CC me as I'm not on the list.

