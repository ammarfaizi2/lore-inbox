Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTJIVMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTJIVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:12:18 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:273 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262587AbTJIVMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:12:17 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (Bill Davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
Date: 9 Oct 2003 21:02:35 GMT
Organization: I need to put my ORGANIZATION here.
Message-ID: <bm4idb$68n$1@gatekeeper.tmr.com>
References: <20031008172235.70d6b794.rddunlap@osdl.org> <Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org> <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>
X-Trace: gatekeeper.tmr.com 1065733355 6423 192.168.12.62 (9 Oct 2003 21:02:35 GMT)
X-Complaints-To: abuse@tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>,
Eric W. Biederman <ebiederm@xmission.com> wrote:
>Cherry George Mathew <cherry@sdf.lonestar.org> writes:
>
>> On Wed, 8 Oct 2003, Randy.Dunlap wrote:
>> 
>> > You'll need to update the kexec-syscall.c file for the correct
>> > kexec syscall number (274).
>> 
>> Is there a consensus about what the syscall number will finally be ? We've
>> jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
>> the Jungle ?
>
>So far the law of the jungle.  Regardless of the rest it looks like it
>is time to submit a place keeping patch.
>
>Eric
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
