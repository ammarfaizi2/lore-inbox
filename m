Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTJAVbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTJAVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:31:21 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48649 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262497AbTJAVbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:31:19 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test6 -- Huh???
Date: 1 Oct 2003 21:21:45 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <blfgh9$j74$1@gatekeeper.tmr.com>
References: <3F79E7EE.80808@coyotegulch.com>
X-Trace: gatekeeper.tmr.com 1065043305 19684 192.168.12.62 (1 Oct 2003 21:21:45 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F79E7EE.80808@coyotegulch.com>,
Scott Robert Ladd  <coyote@coyotegulch.com> wrote:
| I freely admit to being something of a neophyte when it comes to the 
| internal details of the Linux kernel. I've been successfully running 
| development and test kernels since 2.5.40 or so, and I've never before 
| seen anything like the following:
| 
|    Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
|    Tycho vmunix: ris/b/la/up.us0:rr - rdi ptests
| 
|    Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
|    Tycho vmunix: dreruscls/blc:bl: ro-1eangriertas
| 
|    Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
|    Tycho vmunix: ris//cs/lp: lper -rengin sus>dersbasus.csb: or9
|        diprerat<3iv/u/cs/lp up0rr-1eag ntsts
| 
|    Message from syslogd@Tycho at Tue Sep 30 16:09:01 2003 ...
|    Tycho vmunix: ris//cs/lp up0rr -rengin sus>dersbassbc:bl: or9
|        diprerat<3iv/ucl/up. up0rr-1eag ntsts
| 
| The above messages appeared in a root terminal running from Gnome, while 
| I was outside replacing fuses in my truck. Given that my truck is not 
| yet running Linux or connected to my network (give me time...), I'm at a 
| loss as to what caused the above, and what it means.
| 
| Polite illumination will be most graciously appreciated.

The lines are caused by a message such as is sent by the 'write'
command, I suspect something on your system might have an unhappy script
which is abusing that command or using the same mechanism to send you
this information. I think the sender is telling you "I am so confused"
at this point.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
