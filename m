Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbTGINIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbTGINIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:08:36 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:61190 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268233AbTGINI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:08:29 -0400
Subject: Re: 2.5.74-mm3
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200307091138.07580.m.c.p@wolk-project.de>
References: <20030708223548.791247f5.akpm@osdl.org>
	 <200307091106.00781.schlicht@uni-mannheim.de>
	 <20030709021849.31eb3aec.akpm@osdl.org>
	 <200307091138.07580.m.c.p@wolk-project.de>
Content-Type: multipart/mixed; boundary="=-XN3nTDVcsCteWXuNDtmR"
Message-Id: <1057756981.917.8.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 15:23:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XN3nTDVcsCteWXuNDtmR
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

El mi? 09-07-2003 a las 11:38, Marc-Christian Petersen escribió:

> better use the attached one ;)

Still not build


-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

--=-XN3nTDVcsCteWXuNDtmR
Content-Disposition: inline; filename=LOG
Content-Type: text/plain; name=LOG; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

arch/i386/kernel/apm.c: En la función `apm_bios_call':
arch/i386/kernel/apm.c:601: error: error sintáctico before '{' token
arch/i386/kernel/apm.c:595: aviso: unused variable `saved_fs'
arch/i386/kernel/apm.c:595: aviso: unused variable `saved_gs'
arch/i386/kernel/apm.c:596: aviso: unused variable `flags'
arch/i386/kernel/apm.c:598: aviso: unused variable `cpu'
arch/i386/kernel/apm.c:599: aviso: unused variable `save_desc_40'
arch/i386/kernel/apm.c: En el nivel principal:
arch/i386/kernel/apm.c:603: aviso: type defaults to `int' in declaration of `cpu'
arch/i386/kernel/apm.c:603: error: braced-group within expression allowed only inside a function
arch/i386/kernel/apm.c:603: error: error sintáctico before ')' token
arch/i386/kernel/apm.c:604: aviso: type defaults to `int' in declaration of `save_desc_40'
arch/i386/kernel/apm.c:604: error: incompatible types in inicialización
arch/i386/kernel/apm.c:604: error: el elemento inicializador no es constante
arch/i386/kernel/apm.c:604: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:605: aviso: type defaults to `int' in declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:605: error: variable-size type declared outside of any function
arch/i386/kernel/apm.c:605: error: variable-sized object may not be initialized
arch/i386/kernel/apm.c:605: error: conflicting types for `cpu_gdt_table'
include/asm/desc.h:14: error: previous declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:605: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:607: error: error sintáctico before "do"
arch/i386/kernel/apm.c:607: error: `flags' undeclared here (not in a function)
arch/i386/kernel/apm.c:607: aviso: type defaults to `int' in declaration of `__dummy2'
arch/i386/kernel/apm.c:607: error: error sintáctico before "void"
arch/i386/kernel/apm.c:609: error: error sintáctico before "volatile"
arch/i386/kernel/apm.c:610: aviso: type defaults to `int' in declaration of `apm_bios_call_asm'
arch/i386/kernel/apm.c:610: aviso: nombres de parámetros (sin tipos) en la declaración de la función
arch/i386/kernel/apm.c:610: error: conflicting types for `apm_bios_call_asm'
include/asm-i386/mach-default/apm.h:31: error: previous declaration of `apm_bios_call_asm'
arch/i386/kernel/apm.c:610: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:611: error: error sintáctico before "volatile"
arch/i386/kernel/apm.c:612: error: `flags' undeclared here (not in a function)
arch/i386/kernel/apm.c:612: aviso: type defaults to `int' in declaration of `__dummy2'
arch/i386/kernel/apm.c:612: error: error sintáctico before "void"
arch/i386/kernel/apm.c:613: aviso: type defaults to `int' in declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:613: error: variable-size type declared outside of any function
arch/i386/kernel/apm.c:613: error: variable-sized object may not be initialized
arch/i386/kernel/apm.c:613: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:614: error: error sintáctico before "do"
arch/i386/kernel/apm.c: En la función `apm_bios_call_simple':
arch/i386/kernel/apm.c:644: error: error sintáctico before '{' token
arch/i386/kernel/apm.c:636: aviso: unused variable `error'
arch/i386/kernel/apm.c:637: aviso: unused variable `saved_fs'
arch/i386/kernel/apm.c:637: aviso: unused variable `saved_gs'
arch/i386/kernel/apm.c:638: aviso: unused variable `flags'
arch/i386/kernel/apm.c:640: aviso: unused variable `cpu'
arch/i386/kernel/apm.c:641: aviso: unused variable `save_desc_40'
arch/i386/kernel/apm.c: En el nivel principal:
arch/i386/kernel/apm.c:646: aviso: type defaults to `int' in declaration of `cpu'
arch/i386/kernel/apm.c:646: error: redefinition of `cpu'
arch/i386/kernel/apm.c:603: error: `cpu' previously defined here
arch/i386/kernel/apm.c:646: error: braced-group within expression allowed only inside a function
arch/i386/kernel/apm.c:646: error: error sintáctico before ')' token
arch/i386/kernel/apm.c:647: aviso: type defaults to `int' in declaration of `save_desc_40'
arch/i386/kernel/apm.c:647: error: redefinition of `save_desc_40'
arch/i386/kernel/apm.c:604: error: `save_desc_40' previously defined here
arch/i386/kernel/apm.c:647: error: el elemento inicializador no es constante
arch/i386/kernel/apm.c:647: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:648: aviso: type defaults to `int' in declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:648: error: variable-size type declared outside of any function
arch/i386/kernel/apm.c:648: error: variable-sized object may not be initialized
arch/i386/kernel/apm.c:648: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:650: error: error sintáctico before "do"
arch/i386/kernel/apm.c:650: error: `flags' undeclared here (not in a function)
arch/i386/kernel/apm.c:650: aviso: type defaults to `int' in declaration of `__dummy2'
arch/i386/kernel/apm.c:650: error: error sintáctico before "void"
arch/i386/kernel/apm.c:652: error: error sintáctico before "volatile"
arch/i386/kernel/apm.c:653: aviso: type defaults to `int' in declaration of `error'
arch/i386/kernel/apm.c:653: error: `func' undeclared here (not in a function)
arch/i386/kernel/apm.c:653: error: `ebx_in' undeclared here (not in a function)
arch/i386/kernel/apm.c:653: error: `ecx_in' undeclared here (not in a function)
arch/i386/kernel/apm.c:653: error: `eax' undeclared here (not in a function)
arch/i386/kernel/apm.c:653: error: el elemento inicializador no es constante
arch/i386/kernel/apm.c:653: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:654: error: error sintáctico before "volatile"
arch/i386/kernel/apm.c:655: error: `flags' undeclared here (not in a function)
arch/i386/kernel/apm.c:655: aviso: type defaults to `int' in declaration of `__dummy2'
arch/i386/kernel/apm.c:655: error: error sintáctico before "void"
arch/i386/kernel/apm.c:656: aviso: type defaults to `int' in declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:656: error: conflicting types for `cpu_gdt_table'
arch/i386/kernel/apm.c:648: error: previous declaration of `cpu_gdt_table'
arch/i386/kernel/apm.c:656: aviso: data definition has no type or storage class
arch/i386/kernel/apm.c:657: error: error sintáctico before "do"
arch/i386/kernel/apm.c: En la función `apm_power_off':
arch/i386/kernel/apm.c:922: aviso: llaves alrededor del inicializador escalar
arch/i386/kernel/apm.c:922: aviso: (near initialization for `(anonymous)')
arch/i386/kernel/apm.c:922: error: índice de matriz en el inicializador que no es matriz
arch/i386/kernel/apm.c:922: error: (near initialization for `(anonymous)')
arch/i386/kernel/apm.c:922: error: inicializador inválido
arch/i386/kernel/apm.c:922: error: (near initialization for `(anonymous)')
{entrada estándar}: Mensajes del ensamblador:
{entrada estándar}:371: Error: el símbolo `cpu' ya está definido
{entrada estándar}:377: Error: el símbolo `save_desc_40' ya está definido
make[2]: *** [arch/i386/kernel/apm.o] Error 1
make[1]: *** [arch/i386/kernel] Error 2
make: *** [stamp-build] Error 2

--=-XN3nTDVcsCteWXuNDtmR--

