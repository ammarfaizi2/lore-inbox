Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293400AbSCQXjH>; Sun, 17 Mar 2002 18:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312135AbSCQXi5>; Sun, 17 Mar 2002 18:38:57 -0500
Received: from jalon.able.es ([212.97.163.2]:3500 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293400AbSCQXik>;
	Sun, 17 Mar 2002 18:38:40 -0500
Date: Mon, 18 Mar 2002 00:38:30 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: alternative linux configurator prototype v0.2
Message-ID: <20020317233830.GA2679@werewolf.able.es>
In-Reply-To: <3C9396F5.7319AB27@linux-m68k.org> <3C94948E.777B5BAF@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3C94948E.777B5BAF@linux-m68k.org>; from zippel@linux-m68k.org on dom, mar 17, 2002 at 14:05:18 +0100
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.17 Roman Zippel wrote:
>Hi,
>
>I wrote:
>
>> At http://www.xs4all.nl/~zippel/lc.tar.gz you can find a prototype for a
>> new linux configurator (see the included README for build/use
>> information). It has reached a point, where it's becoming usable and I
>> need some feedback on how/if to continue.
>

After seeing all that many tools for kernel config, I always wanted to ask
this.

There is something (as an 'external' viewer) I never understood.
Why nobody has taken the 'obvious' way ?
- Perl is much more extended that python and better? than sh for CML.
- Perl has perl-Curses (for menuconfig)
- Perl has perl-GTK (for xconfig) (so you geet rid of tcl/tk)

Reasons ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Bluebird) for i586
Linux werewolf 2.4.19-pre3-jam3 #1 SMP Fri Mar 15 01:16:08 CET 2002 i686
