Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTG2IpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTG2IpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:45:20 -0400
Received: from snota.svorka.net ([194.19.72.11]:49065 "HELO snota.svorka.net")
	by vger.kernel.org with SMTP id S271331AbTG2IpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:45:07 -0400
From: "Jo Christian Buvarp" <jcb@svorka.no>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 29 Jul 2003 10:45:02 +0200
X-Mailer: PMMail 2000 Professional (2.20.2711) For Windows 2000 (5.1.2600;1)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Problem compiling 2.6.0-test2 under slackware
Message-Id: <S271331AbTG2IpH/20030729084507Z+343@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello :)

I'm using a default installation of slackware 9.0 and got some problems compiling 2.6.0-test kernel (both test1 and test2)
Tried the same configuration on slack 8.1 and slack 9.0, and while slack 8.1 compiles fine, slack 9.0 compiles with the following errors:

CHK     include/linux/compile.h
  CC      arch/i386/mach-default/setup.o
../kernel: Not a directory
make[1]: *** [arch/i386/mach-default/setup.o] Error 1
make: *** [arch/i386/mach-default] Error 2

And stops there :/
Slack 9.0 uses gcc 3.2.2

Any ideas what chould be wrong ??  



mvh
Jo Christian Buvarp
Svorka Aksess



