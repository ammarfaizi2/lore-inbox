Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSHXIsN>; Sat, 24 Aug 2002 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSHXIsN>; Sat, 24 Aug 2002 04:48:13 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:29416
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S315419AbSHXIsM> convert rfc822-to-8bit; Sat, 24 Aug 2002 04:48:12 -0400
Message-ID: <20020824085224.17311.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: Preempt note in the logs
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sat, 24 Aug 2002 11:52:24 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just installed the preempt stuff on a 2.4.19 here
running on a laptop and keep getting the
"dreaded"  exited with preempt_count 1
messages.
there is modprobe,kdeinit,aplay,less,find,grep,automount
and others misbehaving.

As this is a laptop and I would like to save as much battery as
I can by keeping the disk not spinning, this behaviour will
flush the log to the disk all the time.

Would it be too much to ask if I requested that the creator of
this very useful patch would make it possible to switch this note
off through a sysctl ?

BRGDS


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


