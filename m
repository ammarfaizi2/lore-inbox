Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSK2Md7>; Fri, 29 Nov 2002 07:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSK2Md7>; Fri, 29 Nov 2002 07:33:59 -0500
Received: from tomts17.bellnexxia.net ([209.226.175.71]:29151 "EHLO
	tomts17-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267030AbSK2Md6>; Fri, 29 Nov 2002 07:33:58 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [ALPHA RELEASE] module-init-tools 0.9-alpha
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Fri, 29 Nov 2002 07:36:20 -0500
References: <20021129111730.132532C316@lists.samba.org>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021129123620.C8C581591@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> 0.9-alpha Version
> o Fixed patch in NEWS to leave #include linux/elf.h, needed for
>   CONFIG_KALLSYMS.
> o Fixed extra newline in "in use by" message.
> o Fixed parsing for new-style /proc/modules.
> o Fixed version parsing code (thanks to Adam Richter's report)
> o Fixed "running out of filedescriptors" (Adam Richter)
> o Implemented options in modprobe
> o Implemented install in modprobe
> o Implemented options in modules.conf2modprobe.conf
> o Implemented install in modules.conf2modprobe.conf
> o Implemented probeall in modules.conf2modprobe.conf
> o Implemented probe in modules.conf2modprobe.conf
> o Changed modprobe version to be constant string, for "strings" to work
> easily.
> 
> Lightly tested, but seems to work here.  No source RPM, since it's
> still alpha.

Rusty,

What are the full set of patches that should be applied to take  
advantage of the latest module-init-tools?  There has been a lot of
traffic on lkml on modules with lots of little patches.  Its not at
all obvious just what needs be applied to 49/50.

Suspect that almost everything will once the correct patches are applied,
if we get the correct patches...

TIA
Ed Tomlinson

