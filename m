Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUHUGWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUHUGWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268865AbUHUGWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:22:21 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:1032 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S268864AbUHUGWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:22:20 -0400
Date: Sat, 21 Aug 2004 08:22:13 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: usenet-20040502@usenet.frodoid.org, miles.lane@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
In-Reply-To: <20040820231216.6e67817b.davem@redhat.com>
Message-ID: <Pine.LNX.4.60L.0408210821020.3003@rudy.mif.pg.gda.pl>
References: <200408191822.48297.miles.lane@comcast.net>
 <87hdqyogp4.fsf@killer.ninja.frodoid.org> <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl>
 <20040820231216.6e67817b.davem@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1511519478-1093069333=:3003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1511519478-1093069333=:3003
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Aug 2004, David S. Miller wrote:

> On Sat, 21 Aug 2004 08:03:10 +0200 (CEST)
> Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl> wrote:
>
>> [1] Remember: if you want profile some part of code you mast _first_
>> (re)compile them with profiling enabled.
>
> If you use oprofile or valgrind, no you don't.

Of course .. but oprofile can't be used on areas where DTrace can be :)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-1511519478-1093069333=:3003--
