Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSLBV01>; Mon, 2 Dec 2002 16:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLBV01>; Mon, 2 Dec 2002 16:26:27 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S265266AbSLBV0Z>; Mon, 2 Dec 2002 16:26:25 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Andreas Schwab'" <schwab@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [2.4.20] problem with updating time fields?
Date: Mon, 2 Dec 2002 22:33:52 +0100
Message-ID: <003c01c29a4a$82bdcf10$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <jevg2cb20g.fsf@sykes.suse.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

|> Bug? Or am I ignorant?
A> Check out the timezone.

Not set, as far as I can see: date says they're both in
CET (central european time?).
Also: both machines sync themselves against the same NTP-
server.

folkert@muur:~$ date
Mon Dec  2 22:32:01 CET 2002

folkert@keetweej:~/website/current/web$ date
Mon Dec  2 22:32:05 CET 2002

(yeah, it took 4 seconds to switch from `muur' to `keetweej' :-])

