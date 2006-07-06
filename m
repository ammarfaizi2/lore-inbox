Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWGFT3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWGFT3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWGFT3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:29:44 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:44771 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1750749AbWGFT3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:29:43 -0400
Message-ID: <44AD6493.8070803@colorfullife.com>
Date: Thu, 06 Jul 2006 21:29:23 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Michael Kerrisk <mtk-manpages@gmx.net>, mtk-lkml@gmx.net,
       rlove@rlove.org, roland@redhat.com, eggert@cs.ucla.edu,
       paire@ri.silicomp.fr, tytso@mit.edu, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com> <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org> <44AD644E.5070108@colorfullife.com>
In-Reply-To: <44AD644E.5070108@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> select uses ERESTARTSYS...
>
Sorry - I meant ERESTARTNOHAND

--
    Manfred
