Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTKTWxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKTWxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:53:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53005 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263060AbTKTWxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:53:35 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: AW: HT enable on BIOS which doesn't supports it?
Date: 20 Nov 2003 22:42:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bpjg15$ans$1@gatekeeper.tmr.com>
References: <20031118165605.39280.qmail@web40903.mail.yahoo.com>
X-Trace: gatekeeper.tmr.com 1069368165 11004 192.168.12.62 (20 Nov 2003 22:42:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031118165605.39280.qmail@web40903.mail.yahoo.com>,
Bradley Chapman  <kakadu_croc@yahoo.com> wrote:

| My CPU is like that too:
| 
| processor       : 0
| vendor_id       : GenuineIntel
| cpu family      : 15
| model           : 2
| model name      : Mobile Intel(R) Pentium(R) 4 - M CPU 2.00GHz
| stepping        : 7
| cpu MHz         : 1994.259
| cache size      : 512 KB
| fdiv_bug        : no
| hlt_bug         : no
| f00f_bug        : no
| coma_bug        : no
| fpu             : yes
| fpu_exception   : yes
| cpuid level     : 2
| wp              : yes
| flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
| clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
| bogomips        : 3932.16
| 
| I also have an 'ht' flag -- but I've never tried SMP. XP doesn't seem to think HT
| is on here either, so I just put it down as an anomaly.

You can have the HT feature with only one sibling. The value of this is
not obvious, and I have no idea if the 2nd sib is really disabled or if
it is missing. You can find good discussion in comp.sys.intel and some
of the conspiracy groups, I bet.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
