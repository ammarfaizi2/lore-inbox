Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282979AbRLVXjW>; Sat, 22 Dec 2001 18:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282976AbRLVXjM>; Sat, 22 Dec 2001 18:39:12 -0500
Received: from jalon.able.es ([212.97.163.2]:21438 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S282979AbRLVXjD>;
	Sat, 22 Dec 2001 18:39:03 -0500
Date: Sun, 23 Dec 2001 00:41:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mike Black <mblack@csihq.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17
Message-ID: <20011223004104.G6735@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0112211439390.7313-100000@freak.distro.conectiva> <002701c18adf$b9f0f140$ac542341@cfl.rr.com> <20011222185940.6a646662.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011222185940.6a646662.skraw@ithnet.com>; from skraw@ithnet.com on Sat, Dec 22, 2001 at 18:59:40 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011222 Stephan von Krawczynski wrote:
>On Sat, 22 Dec 2001 06:56:44 -0500
>"Mike Black" <mblack@csihq.com> wrote:
>
>> My thanks to for Marcelo's efforts...but....
>> 
>> Is there any way we can get Marcelo, Rik, and Andrea to work together on the
>> "stable" version now (a Linux tribunal)?
>
>Would you mind to give us a short hint on the implicit "instability" you are
>exactly talking about? I think 2.4.17 is in various ways well worked out and
>maintained. There are further improvements possible for sure, but that is a
>normal thing. Anyway I cannot really see any major instability issues that
>require instant brainstorming. I am confident in Marcelo's maintenance.
>

They are not different branches. Perhaps what is confusing him (and sometimes
also confuses me), is that there are patches in aa kernel (I am not a
compulsive patcher...) that look like basic bug fixes or simple but effective
enhancements that never reach mainline, they are only in aa for ages (looking
at andrea's dir in ftp.kernel.org: all the _vm patches, the spinlock-cacheline,
compiler.h, rwsem, parent-timeslice, etc.). Nothing wrt numa, tux, uml or lvm.

How about a 18-pre1 taking from aa all that is usefull and not really intrusive ?


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17-beo #1 SMP Fri Dec 21 21:39:36 CET 2001 i686
