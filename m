Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSIAWAF>; Sun, 1 Sep 2002 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIAWAF>; Sun, 1 Sep 2002 18:00:05 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:30480 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S318131AbSIAWAD>;
	Sun, 1 Sep 2002 18:00:03 -0400
Date: Sun, 1 Sep 2002 17:56:32 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.33 : drivers/hotplug/cpqphp_core.c error
Message-ID: <Pine.LNX.4.44.0209011755040.25625-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While a 'make modules', I received the following error.

Regards,
Frank

In file included from cpqphp_core.c:40:
cpqphp.h: In function `cpq_get_latch_status':
cpqphp.h:698: called object is not a function
cpqphp.h:698: parse error before string constant
cpqphp.h:698: warning: left-hand operand of comma expression has no effect
cpqphp.h:698: warning: left-hand operand of comma expression has no effect
cpqphp.h:698: warning: left-hand operand of comma expression has no effect
cpqphp.h:698: parse error before `)'
cpqphp.h: In function `wait_for_ctrl_irq':
cpqphp.h:736: called object is not a function
cpqphp.h:736: parse error before string constant
cpqphp.h:736: warning: left-hand operand of comma expression has no effect
cpqphp.h:736: parse error before `)'
cpqphp.h:746: called object is not a function
cpqphp.h:746: parse error before string constant
cpqphp.h:746: warning: left-hand operand of comma expression has no effect
cpqphp.h:746: parse error before `)'
cpqphp_core.c: In function `ctrl_slot_setup':
cpqphp_core.c:317: called object is not a function
cpqphp_core.c:317: parse error before string constant
cpqphp_core.c:317: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:317: parse error before `)'
cpqphp_core.c: In function `get_slot_mapping':
cpqphp_core.c:479: called object is not a function
cpqphp_core.c:479: parse error before string constant
cpqphp_core.c:479: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:479: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:479: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:479: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:479: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:479: parse error before `)'
cpqphp_core.c: In function `set_attention_status':
cpqphp_core.c:595: called object is not a function
cpqphp_core.c:595: parse error before string constant
cpqphp_core.c:595: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:595: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:595: parse error before `)'
cpqphp_core.c: In function `process_SI':
cpqphp_core.c:630: called object is not a function
cpqphp_core.c:630: parse error before string constant
cpqphp_core.c:630: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:630: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:630: parse error before `)'
cpqphp_core.c: In function `process_SS':
cpqphp_core.c:670: called object is not a function
cpqphp_core.c:670: parse error before string constant
cpqphp_core.c:670: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:670: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:670: parse error before `)'
cpqphp_core.c: In function `hardware_test':
cpqphp_core.c:698: called object is not a function
cpqphp_core.c:698: parse error before string constant
cpqphp_core.c:698: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:698: parse error before `)'
cpqphp_core.c: In function `get_power_status':
cpqphp_core.c:719: called object is not a function
cpqphp_core.c:719: parse error before string constant
cpqphp_core.c:719: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:719: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:719: parse error before `)'
cpqphp_core.c: In function `get_attention_status':
cpqphp_core.c:737: called object is not a function
cpqphp_core.c:737: parse error before string constant
cpqphp_core.c:737: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:737: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:737: parse error before `)'
cpqphp_core.c: In function `get_latch_status':
cpqphp_core.c:755: called object is not a function
cpqphp_core.c:755: parse error before string constant
cpqphp_core.c:755: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:755: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:755: parse error before `)'
cpqphp_core.c: In function `get_adapter_status':
cpqphp_core.c:774: called object is not a function
cpqphp_core.c:774: parse error before string constant
cpqphp_core.c:774: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:774: warning: left-hand operand of comma expression has no effect
cpqphp_core.c:774: parse error before `)'
cpqphp_core.c: In function `cpqhpc_probe':
cpqphp_core.c:823: called object is not a function
cpqphp_core.c:823: parse error before string constant
cpqphp_core.c:834: called object is not a function
cpqphp_core.c:834: parse error before string constant
cpqphp_core.c:841: called object is not a function
cpqphp_core.c:841: parse error before string constant
cpqphp_core.c:1056: called object is not a function
cpqphp_core.c:1056: parse error before string constant
cpqphp_core.c:1083: called object is not a function
cpqphp_core.c:1083: parse error before string constant
make[2]: *** [cpqphp_core.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/hotplug'
make[1]: *** [hotplug] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2

