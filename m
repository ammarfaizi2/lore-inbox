Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSBJNbt>; Sun, 10 Feb 2002 08:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289627AbSBJNb2>; Sun, 10 Feb 2002 08:31:28 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:25481 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289621AbSBJNbK>; Sun, 10 Feb 2002 08:31:10 -0500
Message-ID: <3C66743C.9BA03219@folkwang-hochschule.de>
Date: Sun, 10 Feb 2002 14:23:08 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: nettings@folkwang-hochschule.de
Subject: funny console prob w/2.4.18-pre[479]+kpreempt+sched-o(1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello *

it happens to me regularly that the x server dies without any
obvious reason.
funny thing is, it takes the virtual text consoles with it, which is
why i'm posting here.

i end up in kdm and i can restart x alright, but when i switch vc's,
all i see is a frozen image of the x screen. i can switch back to x,
and it runs.

all tasks i started on the vc's before keep running, the mingettys
are there, the bashes are there, and i can even blind-type commands
that will run correctly. only the display is messed up.
a blind-typed "reset" has no effect.

any clues ?
i'm using x version 4.2.0 with a voodoo3 card (dri and agp enabled).
this is an smp box with 2 p3/600 katmai.
might this be not a kernel issue, but an x11 problem ?

best wishes,

jörn


please keep be cc:ed, i only read lkml archives.



-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
