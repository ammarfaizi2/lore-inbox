Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292244AbSBTTtK>; Wed, 20 Feb 2002 14:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBTTtB>; Wed, 20 Feb 2002 14:49:01 -0500
Received: from zero.tech9.net ([209.61.188.187]:33043 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292244AbSBTTss>;
	Wed, 20 Feb 2002 14:48:48 -0500
Subject: Re: 2.5.5 fails to compile
From: Robert Love <rml@tech9.net>
To: Pau Aliagas <linuxnow@wanadoo.es>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0202201658300.1941-100000@pau.intranet.ct>
In-Reply-To: <Pine.LNX.4.44.0202201658300.1941-100000@pau.intranet.ct>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 14:48:49 -0500
Message-Id: <1014234530.18361.45.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-02-20 at 11:00, Pau Aliagas wrote:

> from init/main.c:15: /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:
> In  function `thread_saved_pc': /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:444: 
> dereferencing pointer to incomplete type /home/pau/LnxZip/RPM/BUILD/kernel-2.5.4/include/asm/processor.h:445: 

This is 2.5.4, not 2.5.5, no?

The bug was fixed in 2.5.5-pre1 and thus in 2.5.5, too.

	Robert Love

