Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKOMYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 07:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKOMYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 07:24:49 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:29987 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261680AbTKOMYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 07:24:47 -0500
Message-ID: <3FB61B0C.8030509@gmx.net>
Date: Sat, 15 Nov 2003 13:24:44 +0100
From: Eric <plukje@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030911
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: (AGP/SMP) following code leads to include errors (ERROR
 LOG UPDATE)
References: <3FB61091.7010804@gmx.net>
In-Reply-To: <3FB61091.7010804@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------030507050102000408070003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507050102000408070003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Previous post contained a wrong logfile, this is the correct one.



--------------030507050102000408070003
Content-Type: text/plain;
 name="tmp_vma253.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tmp_vma253.log"

In file included from /usr/src/linux-2.6.0-test9/include/asm/smp.h:18,
                 from /usr/src/linux-2.6.0-test9/include/linux/smp.h:17,
                 from /usr/src/linux-2.6.0-test9/include/linux/sched.h:23,
                 from /usr/src/linux-2.6.0-test9/include/linux/mm.h:4,
                 from tmp_vmasrc.c:3:
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
In file included from /usr/src/linux-2.6.0-test9/include/asm/smp.h:18,
                 from /usr/src/linux-2.6.0-test9/include/linux/smp.h:17,
                 from /usr/src/linux-2.6.0-test9/include/linux/sched.h:23,
                 from /usr/src/linux-2.6.0-test9/include/linux/mm.h:4,
                 from tmp_vmasrc.c:3:
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:8: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:9: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:10: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:12: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:19: error: `MAX_APICS' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:20: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:20: error: conflicting types for `mp_bus_id_to_type'
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:8: error: previous declaration of `mp_bus_id_to_type'
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:22: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:24: error: `MAX_MP_BUSSES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:24: error: conflicting types for `mp_bus_id_to_pci_bus'
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:12: error: previous declaration of `mp_bus_id_to_pci_bus'
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:54: error: `MAX_APICS' undeclared here (not in a function)
In file included from /usr/src/linux-2.6.0-test9/include/asm/smp.h:20,
                 from /usr/src/linux-2.6.0-test9/include/linux/smp.h:17,
                 from /usr/src/linux-2.6.0-test9/include/linux/sched.h:23,
                 from /usr/src/linux-2.6.0-test9/include/linux/mm.h:4,
                 from tmp_vmasrc.c:3:
/usr/src/linux-2.6.0-test9/include/asm/io_apic.h:120: error: `MAX_IRQ_SOURCES' undeclared here (not in a function)
/usr/src/linux-2.6.0-test9/include/asm/io_apic.h:120: error: conflicting types for `mp_irqs'
/usr/src/linux-2.6.0-test9/include/asm/mpspec.h:22: error: previous declaration of `mp_irqs'
In file included from /usr/src/linux-2.6.0-test9/include/linux/smp.h:17,
                 from /usr/src/linux-2.6.0-test9/include/linux/sched.h:23,
                 from /usr/src/linux-2.6.0-test9/include/linux/mm.h:4,
                 from tmp_vmasrc.c:3:
/usr/src/linux-2.6.0-test9/include/asm/smp.h:73:26: mach_apicdef.h: No such file or directory


--------------030507050102000408070003--

