Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbQLNB4F>; Wed, 13 Dec 2000 20:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131001AbQLNBzy>; Wed, 13 Dec 2000 20:55:54 -0500
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:1768 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129860AbQLNBzl>; Wed, 13 Dec 2000 20:55:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: dep <dennispowell@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Re: test12 lockups -- need feedback
Date: Wed, 13 Dec 2000 20:28:04 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <3A3804CA.E07FDBB1@haque.net> <xy7hf47n95t.fsf@mdj.nada.kth.se> <xy7d7evn8ud.fsf@mdj.nada.kth.se>
In-Reply-To: <xy7d7evn8ud.fsf@mdj.nada.kth.se>
MIME-Version: 1.0
Message-Id: <00121320280401.03451@depoffice.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 December 2000 19:29, Mikael Djurfeldt wrote:

| > I downloaded the full test12 and have lockups after using X
| > (upstream version 4.0.1Z) 15-45 mins.  For me, SysRq+u works, but
| > if I then press SysRq+b, nothing happens.  There are no signs in
| > the syslog.
|
| I should add that I didn't have these lockups in test12-pre8.

just for statistical purposes, test12 has been running problem-free 
here on a k6-2-550 (running at 500), glibc-2.2, built with 
gcc-2.95-2, since about an hour after it was announced. no anomalies 
at all, and the cd reader has become reliable again. in X the entire 
time, and heavy system activity with a wide variety of applications.
-- 
dep
--
bipartisanship: an illogical construct not unlike the idea that
if half the people like red and half the people like blue, the 
country's favorite color is purple.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
