Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292254AbSBTTzK>; Wed, 20 Feb 2002 14:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292253AbSBTTzB>; Wed, 20 Feb 2002 14:55:01 -0500
Received: from 213-97-45-174.uc.nombres.ttd.es ([213.97.45.174]:30983 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id <S292254AbSBTTy1>;
	Wed, 20 Feb 2002 14:54:27 -0500
Date: Wed, 20 Feb 2002 20:54:18 +0100 (CET)
From: Pau Aliagas <linuxnow@wanadoo.es>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.5 fails to compile
In-Reply-To: <1014234530.18361.45.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0202202053000.11844-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Feb 2002, Robert Love wrote:

> On Wed, 2002-02-20 at 11:00, Pau Aliagas wrote:
> 
> > from init/main.c:15: /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:
> > In  function `thread_saved_pc': /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:444: 
> > dereferencing pointer to incomplete type /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:445: 
> 
> This is 2.5.4, not 2.5.5, no?
> 
> The bug was fixed in 2.5.5-pre1 and thus in 2.5.5, too.

Sorry, that's it. I compiled the bad tree :(

Pau

