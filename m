Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSCSVOW>; Tue, 19 Mar 2002 16:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292817AbSCSVOG>; Tue, 19 Mar 2002 16:14:06 -0500
Received: from prosecco.gmx.net ([213.165.64.8]:60145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292836AbSCSVNp>;
	Tue, 19 Mar 2002 16:13:45 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: System hanging at boot with ms natural pro keyboard in usb port (2.4.18)
Date: Tue, 19 Mar 2002 22:04:28 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203192204.32846.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi
I tried to connect my MS Natural Pro keyboard and than I get this error.
The Logitech mouse works great ;)

Is this solved in 2.4.19-pre3 ?

The error:

hub.c USB new device connect on bus 1/1, assinged device number 2
invalid operand: 0000
CPU:		0
EIP:		0010:[<d98730a0>] Not tainted
EELAGS:	0010046
... write me if you need more ...
<0> Kernel panic: Aiee, Killing interupt Handler
In Interupt handler - not syncing


I think it is not very good if ther kernel doesn't supports microsoft 
hardware. If there are problems they will never switch completly from 
Microsoft to Microhard ;)

I've tried bouth config options:
Full HID and basic


thanks
have fun
Felix
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8l6fgS0DOrvdnsewRAs67AJ99JXfWT05oZpHS5oOyId+3/FB5WwCfTMq+
lo9eZv5tRZxufrJ4oSosXjQ=
=ikNl
-----END PGP SIGNATURE-----

