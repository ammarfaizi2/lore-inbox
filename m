Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTICICY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbTICICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 04:02:24 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:14091 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261512AbTICICT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 04:02:19 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Date: Wed, 3 Sep 2003 08:02:18 +0000 (UTC)
Organization: Cistron
Message-ID: <bj476a$l1g$1@news.cistron.nl>
References: <bj447c$el6$1@news.cistron.nl> <20030903074902.GA1786@deimos.one.pl>
X-Trace: ncc1701.cistron.net 1062576138 21552 62.216.30.38 (3 Sep 2003 08:02:18 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Kolkowski  <deimos@deimos.one.pl> wrote:
>It's standard APIC bug that no one care!

That's a pitty, perhaps none of the developers has (serial-)access to one
of such machines and thus noway  of checking/fixing?

>I have via_kt-400 on ecs_l7vta, just check my previous post:
>#Message-ID: <20030902110335.GA540@deimos.one.pl>
>#Subject: [BUG] - 2.{4,6}.{22,0-test4} - CONFIG_X86_UP_APIC lack routing on eth

some kernel do work with my hardware. which makes it even stranger!

>P.S. I you wont to use eth with that kernel, silmpe uncompile
>CONFIG_X86_UP_APIC and use APM.

ok, will do that for now.

>PP.S. Maby you have ATI card? Bug with setfonts and loadkeys on 1 tty it's
>from time to time :-)

nope, mini-itx has everything on board. I intend to use mine as a firewall
with dot1Q vlan capabilities. text-only! ;-)

Danny

-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

