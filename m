Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTBRMcb>; Tue, 18 Feb 2003 07:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTBRMcb>; Tue, 18 Feb 2003 07:32:31 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:11194 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267744AbTBRMca>; Tue, 18 Feb 2003 07:32:30 -0500
Message-ID: <20030218124218.20981.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: ciarrocchi@linuxmail.org
Date: Tue, 18 Feb 2003 20:42:18 +0800
Subject: Make rpm doesn't work
X-Originating-Ip: 62.101.98.215
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I tried the following:
[root@frodo linux-2.5.61]# make rpm
make: *** No rule to make target `clean', needed by `rpm'.  Stop.

Not because I really need an rpm kernel, just because I wanted
to try the process.

I looked at the Makefile but I can't understand why it doesn't 
work.

Do you have to fill a bug report to bugzilla.kernel.org ?

Ciao,
       Paolo


-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
