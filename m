Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSGXI6N>; Wed, 24 Jul 2002 04:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSGXI6N>; Wed, 24 Jul 2002 04:58:13 -0400
Received: from [213.69.232.58] ([213.69.232.58]:40457 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S313773AbSGXI6M>;
	Wed, 24 Jul 2002 04:58:12 -0400
Date: Wed, 24 Jul 2002 13:01:21 +0200
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cpu speed is 165mhz instead of real 650mhz
Message-ID: <20020724110121.GA1925@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys!

This periodicly appears in my system. The Kernel seems to misdetect the
right cpu speed and then it's running only at 165mhz.
I don't really understand why this happens, there's no acpi enabled, which
caused this failure the last time.

I attached .config of 2.5.24 [which still runs fine with devfs :) ]
and /proc/cpuinfo.

Please cc me when answering.

Nico

-- 
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt mails
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)
