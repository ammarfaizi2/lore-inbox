Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265631AbUFDF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbUFDF4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUFDF4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:56:19 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:189 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S265631AbUFDF4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:56:16 -0400
Date: Fri, 4 Jun 2004 15:56:13 +1000
From: "Pods" <pods@dodo.com.au>
To: linux-kernel@vger.kernel.org
Reply-to: "Pods" <pods@dodo.com.au>
Subject: lotsa oops - 2.6.5 (preempt + unable handle virutal address + more?)
X-Priority: 3
X-Mailer: Dodo Internet Webmail Server 
X-Original-IP: 203.220.42.35
Content-Transfer-Encoding: 7BIT
X-MSMail-Priority: Medium
Importance: Medium
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <E1BW7gZ-00066c-00@mail.kbs.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for the not very descriptive subject.

I have a problem with linux 2.6.5, it crashes, a lot. Some times it spews
out oops at me, sometimes i dotn know if it oopsed or not because the
machine doesnt respond.

I can reproduce this by several means, including playing a dvd, compiling
firefox, mplayer or thunderbird and i can be doing something not quite a
hard on the system such as browsing the web or chatting... It'll find some
way to piss me off.

Now, i have supplied several oops, each on containing the full output of
dmesg via the kernel logging daemon. I have also supplied my hardware specs
(mobo + lspci -vvv) and out put of ver_linux?... All these files can be
found @ http://users.quickfox.org/~pods/linux-issues/.

I didnt want to post them here because each oops IIRC is different. Just to
let you know if have tried several way in which to correct this.

* several different kernels ( 2.4.18-bf24, 2.4.26, 2.6.5 )
** with ide shareirq
** noapic
** + apic
** noacpi
** + acpi
** lots of other differences

* Recently i had turned to bios and have disabled many things including apic
(just incase you where wondering, bios had mps @ 1.4)

If you would rather me add the very large amoung of oops to this email, tell
me and i'll do so. Thanks in advance.

P.S Im not subscribed to the list, i may consider it depending on the amount
of feedback i get and how involved i need to be, but for now i'd rather if
people could CC me their response. Thank you
again.

________________________________________________

Message sent using
Dodo Internet Webmail Server

