Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292846AbSBVL4S>; Fri, 22 Feb 2002 06:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292848AbSBVL4J>; Fri, 22 Feb 2002 06:56:09 -0500
Received: from [200.181.68.90] ([200.181.68.90]:28597 "EHLO www5.mailbr.com.br")
	by vger.kernel.org with ESMTP id <S292845AbSBVLzx>;
	Fri, 22 Feb 2002 06:55:53 -0500
Message-Id: <200202221145.g1MBjkj05721@www5.mailbr.com.br>
Content-Type: text/plain
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?=DFuzzLinux?= <buzz@linuxbr.com.br>
Organization: RedHat
X-Originating-Ip: 200.136.189.9
Mime-Version: 1.0
Reply-To: =?ISO-8859-1?Q?=DFuzzLinux?= <buzz@linuxbr.com.br>
Date: Sex, 22 Fev 2002 8:45:46
X-Mailer: EMUmail 3.1_XX
Subject: error with =?ISO-8859-1?Q?binfmt=B4s?= modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have compiled a kernel 2.4.17 and with binfmt_aout.o, binfmt_misc.o 
and binfmt_elf.o modules.
When I try to add binfmt_misc.o modules he says: device or resource 
busy, and with the red hat 7.2 kernel (2.4.7-10) I could add with no 
error this modules
The binfmt_elf.o modules return unresolved symbols.
And, when I try to enter boot teh vmlinuz-2.4.17 it returns a fatal 
error:
kmod: /sbin/modprobe -s -k binfmt*****.....

Plese fix these bugs



iBEST - Internet com alta qualidade de conexão.
GANHE ACESSO GRATUITO à Internet do iBEST em
http://discador.ibest.com.br
