Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJ1OvM>; Mon, 28 Oct 2002 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbSJ1OvM>; Mon, 28 Oct 2002 09:51:12 -0500
Received: from mx0.gmx.net ([213.165.64.100]:9603 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S261282AbSJ1OvM>;
	Mon, 28 Oct 2002 09:51:12 -0500
Date: Mon, 28 Oct 2002 15:57:28 +0100 (MET)
From: Norbert Rooss <zaeld@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <11192.1035805085@www42.gmx.net>
Subject: Re: tty drivers: Is put_char mandatory?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0004530950@gmx.net
X-Authenticated-IP: [62.8.145.242]
Message-ID: <31423.1035817048@www38.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Simple question: Is the implementation of the function put_char() for tty
> drivers mandatory?

Oh sorry, I didn't see that a default put_char() is used in this case..

-- 
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

