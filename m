Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281931AbRKUSFq>; Wed, 21 Nov 2001 13:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281927AbRKUSFh>; Wed, 21 Nov 2001 13:05:37 -0500
Received: from palrel13.hp.com ([156.153.255.238]:58631 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S281395AbRKUSFa>;
	Wed, 21 Nov 2001 13:05:30 -0500
Message-ID: <3BFBECE4.BD24CD73@cup.hp.com>
Date: Wed, 21 Nov 2001 10:05:24 -0800
From: Rafael Hernandez <rafael@cup.hp.com>
Reply-To: rhernandez@hp.com
X-Mailer: Mozilla 4.76 [en] (X11; U; HP-UX B.11.00 9000/889)
X-Accept-Language: en
MIME-Version: 1.0
To: ia64-list@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: SHM_REMAP
In-Reply-To: <200111200043.QAA32367@wilson.cygnus.com> <3BFA9D0F.F0BFDEEA@cup.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in sys/shm.h and in  bits/shm.h there's defined a flag  SHM_REMAP

but I don't see it being used anywhere in the kernel. This was used in 2.2.x
kernels
in the file ipc/shm.c but I have looked for it in the latest 2.4.14 and it seems
it not used
anymore and it's not used in the Itanium RedHat linux-2.4.7-2 we have installed
either.

Has this support for SHM_REMAP been droped or am I missing someting?

Thanks in advance,
Rafa

--
                   __         Rafael M. Hernandez
                  / /\          Enterprise Software Technology Lab
        __       / /  \         Core HP-UX Operation
       /_/\     /_/ /\ \      e-mail: rafael@cup.hp.com
       \ \ \  __\ \ \_\ \     e-mail: rhernandez@hp.com
        \ \ \/ /\\ \ \/ /     Hewlett-Packard Company
         \ \ \/\ \\ \ \/      19447 Pruneridge Ave.
          \ \ \ \ \\ \ \      MailStop 47LT
           \ \ \_\/ \ \ \     Cupertino, CA 95014-0603
            \ \ \    \_\/     Tel: 1-(408)-447-3637
             \_\/             Telnet : 447-3637

~
~



