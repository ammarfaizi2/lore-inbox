Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTDKIW2 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 04:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTDKIW2 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 04:22:28 -0400
Received: from web20102.mail.yahoo.com ([216.136.226.39]:15132 "HELO
	web20102.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264321AbTDKIWX (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 04:22:23 -0400
Message-ID: <20030411083406.93618.qmail@web20102.mail.yahoo.com>
Date: Fri, 11 Apr 2003 01:34:06 -0700 (PDT)
From: Alisha Nigam <mail_to_alisha@yahoo.com>
Subject: Re: TCP/IP stack related prob.
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1050047551.1415.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   
   its not working againg giving a bundle of errors 
so any suggession ????????????????

p10.c:1:1: warning: "MODULE" redefined
p10.c:1:1: warning: this is the location of the
previous definition
p10.c:2:1: warning: "__KERNEL__" redefined
p10.c:1:1: warning: this is the location of the
previous definition
In file included from
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:13,
                 from
/lib/modules/2.4.18-14/build/include/linux/list.h:6,
                 from
/lib/modules/2.4.18-14/build/include/linux/module.h:12,
                 from p10.c:3:
/lib/modules/2.4.18-14/build/include/asm/processor.h:490:
warning: no previous prototype for `prefetch'
In file included from
/lib/modules/2.4.18-14/build/include/asm/system.h:8,
                 from
/lib/modules/2.4.18-14/build/include/asm/semaphore.h:39,
                 from
/lib/modules/2.4.18-14/build/include/linux/fs.h:200,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:19,
                 from p10.c:4:
/lib/modules/2.4.18-14/build/include/linux/bitops.h:45:
warning: no previous prototype for `generic_fls'
/lib/modules/2.4.18-14/build/include/linux/bitops.h:74:
warning: no previous prototype for `get_bitmask_order'
In file included from
/lib/modules/2.4.18-14/build/include/linux/fs.h:201,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:19,
                 from p10.c:4:
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:14:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:28:
warning: type qualifiers ignored on function return
type
In file included from
/lib/modules/2.4.18-14/build/include/linux/byteorder/little_endian.h:11,
                 from
/lib/modules/2.4.18-14/build/include/asm/byteorder.h:45,
                 from
/lib/modules/2.4.18-14/build/include/linux/fs.h:201,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:19,
                 from p10.c:4:
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:132:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:145:
warning: type qualifiers ignored on function return
type
/lib/modules/2.4.18-14/build/include/linux/byteorder/swab.h:159:
warning: type qualifiers ignored on function return
type
In file included from
/lib/modules/2.4.18-14/build/include/linux/fs.h:375,
                 from
/lib/modules/2.4.18-14/build/include/linux/capability.h:17,
                 from
/lib/modules/2.4.18-14/build/include/linux/binfmts.h:5,
                 from
/lib/modules/2.4.18-14/build/include/linux/sched.h:9,
                 from
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:19,
                 from p10.c:4:
/lib/modules/2.4.18-14/build/include/linux/quota.h:176:
warning: no previous prototype for `mark_info_dirty'
In file included from
/lib/modules/2.4.18-14/build/include/linux/sched.h:26,
                 from
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:19,
                 from p10.c:4:
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `sigorsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:108:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `sigandsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:111:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `signandsets':
/lib/modules/2.4.18-14/build/include/linux/signal.h:114:
warning: comparison of unsigned expression < 0 is
always false
/lib/modules/2.4.18-14/build/include/linux/signal.h:
In function `signotset':
/lib/modules/2.4.18-14/build/include/linux/signal.h:140:
warning: comparison of unsigned expression < 0 is
always false
In file included from p10.c:4:
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `__pskb_pull':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:855:
warning: comparison between signed and unsigned
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `pskb_may_pull':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:871:
warning: comparison between signed and unsigned
p10.c: At top level:
p10.c:7: warning: no previous prototype for
`init_module'
p10.c: In function `init_module':
p10.c:7: dereferencing pointer to incomplete type
p10.c: At top level:
p10.c:12: warning: no previous prototype for
`cleanup_module'
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:
In function `prefetchw':
/lib/modules/2.4.18-14/build/include/linux/prefetch.h:48:
warning: unused parameter `x'
/lib/modules/2.4.18-14/build/include/linux/wait.h: In
function `__remove_wait_queue':
/lib/modules/2.4.18-14/build/include/linux/wait.h:225:
warning: unused parameter `head'
/lib/modules/2.4.18-14/build/include/linux/pm.h: In
function `pm_access':
/lib/modules/2.4.18-14/build/include/linux/pm.h:150:
warning: unused parameter `dev'
/lib/modules/2.4.18-14/build/include/linux/pm.h: In
function `pm_dev_idle':
/lib/modules/2.4.18-14/build/include/linux/pm.h:151:
warning: unused parameter `dev'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_none':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:32:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_bad':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:33:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pgd_present':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:34:
warning: unused parameter `pgd'
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:
In function `pmd_offset':
/lib/modules/2.4.18-14/build/include/asm/pgtable-2level.h:55:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/linux/mm.h: In
function `arch_validate':
/lib/modules/2.4.18-14/build/include/linux/mm.h:491:
warning: unused parameter `gfp_mask'
/lib/modules/2.4.18-14/build/include/linux/mm.h:491:
warning: unused parameter `order'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `pte_alloc_one':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:107:
warning: unused parameter `mm'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:107:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `pte_alloc_one_fast':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:122:
warning: unused parameter `mm'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:123:
warning: unused parameter `address'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `flush_tlb_range':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:220:
warning: unused parameter `start'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:220:
warning: unused parameter `end'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h: In
function `flush_tlb_pgtables':
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:238:
warning: unused parameter `start'
/lib/modules/2.4.18-14/build/include/asm/pgalloc.h:238:
warning: unused parameter `end'
/lib/modules/2.4.18-14/build/include/linux/highmem.h:
In function `clear_user_highpage':
/lib/modules/2.4.18-14/build/include/linux/highmem.h:83:
warning: unused parameter `vaddr'
/lib/modules/2.4.18-14/build/include/linux/highmem.h:
In function `copy_user_highpage':
/lib/modules/2.4.18-14/build/include/linux/highmem.h:112:
warning: unused parameter `vaddr'
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:
In function `kunmap_skb_frag':
/lib/modules/2.4.18-14/build/include/linux/skbuff.h:1104:
warning: unused parameter `vaddr'




--- Arjan van de Ven <arjanv@redhat.com> wrote:
> On Fri, 2003-04-11 at 09:38, Alisha Nigam wrote:
> 
> >  then compile it 
> >   gcc -c -O -W -Wall -Wstrict-prototypes
> > -Wmissing-prototypes -DMODULE -D__KERNEL__
> -mymodule.o
> > mymodule.c 
> > 
> > 
> >    i am getting a bundle of errors ...... 
> > 
> > 
> > In file included from /usr/include/linux/fs.h:23,
> >                  from
> > /usr/include/linux/capability.h:17,
> >                  from
> /usr/include/linux/binfmts.h:5,
> >                  from
> /usr/include/linux/sched.h:9,
> >                  from
> /usr/include/linux/skbuff.h:19,
> >                  from p10.c:2:
> > /usr/include/linux/string.h:8:2: warning: #warning
> > Using kernel header in userland!
> 
> you are using glibc headers to compile a kernel....
> that's not going to
> work. Add -I/lib/modules/`uname -r`/build/include to
> the gcc commandline
> to use the headers of the currently running kernel..
> 
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
