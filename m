Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTDETcq (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 14:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbTDETcq (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 14:32:46 -0500
Received: from modemcable011.162-200-24.mtl.mc.videotron.ca ([24.200.162.11]:16002
	"HELO chezsoi") by vger.kernel.org with SMTP id S262629AbTDETco (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 14:32:44 -0500
From: "James Watkins-Harvey" <james.watkins-harvey.1@ens.etsmtl.ca>
To: "Anant Aneja" <anantaneja@rediffmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: poweroff problem
Date: Sat, 5 Apr 2003 14:44:58 -0500
Message-ID: <FAEHLJECFOOHNNMFHACOKEIECDAA.james.watkins-harvey.1@ens.etsmtl.ca>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030405060804.31946.qmail@webmail5.rediffmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> I've got a problem with my 2.4.2-2 kernel.

  [...]

> i know that the kernel is old but i dont want to update
> cos my modem has a low download speed

  [...]

> can anyone help me ?


For sure!  You can probably help yourself (and people on the list) by
upgrading your kernel to something a bit newer.  No one still have a box
with such installation, anyway.

Common, your modem is that slow?  Ok, let's say you have a 28.8 KBps...
Should be about 2 hours to download the file; give it a try yourself:
http://internetservices.cnet.com/g/bm/dl/0001.asp?filename=Linux+Kernel+2.4.
20+(tar.bz2)&sd=26.1MB&size=27421046 .  Of course, make sure to download the
bzip version, not the gzip one (
ftp://ftp.kernel.org/pub/linux/kernel/v2.4/linux-2.4.20.tar.bz2 ).

Once installed, make sure to keep a clean version of the kernel tree, so in
the future you can regularly download incremental updates; kernel's patch
are about 1 MB per development month.

Give it a try, then if it still not works, it could be useful to mention it
on LKML.  But then, be preapared to do testing by yourself, cause it seems
like you're the only one experiencing such problems.


> also i cant give u the complete listing of the cpu
> registers since it occurs at the last stage
> of shutdown and i cant copy it to a file
> and am too lazy to write it down


Sorry to say it, but i don't think Linux is a good place for laziness;
actually I know about an operating system developped by lazy programmers for
lazy users...  Don't remember the name ;)




James

