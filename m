Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSLZVdk>; Thu, 26 Dec 2002 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSLZVdj>; Thu, 26 Dec 2002 16:33:39 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:30733 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S263977AbSLZVdj>; Thu, 26 Dec 2002 16:33:39 -0500
Date: Thu, 26 Dec 2002 19:41:25 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Ro0tSiEgE <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian boot-flopppies and 2.5.53 dont mix
Message-ID: <20021226214124.GA19961@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ro0tSiEgE <lkml@ro0tsiege.org>, linux-kernel@vger.kernel.org
References: <200212261538.59540.lkml@ro0tsiege.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212261538.59540.lkml@ro0tsiege.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 26, 2002 at 03:38:59PM -0600, Ro0tSiEgE escreveu:
> I've tried 5 different IRC channels and no one will give me any answers. I 
> created a Debian (woody) install cd for my laptop (no floppy) and the kernel 
> 2.5.53 (2.4 and below have VERY weird issues with my pavilion notebook and 
> the ALi chipset, which still no one can give an answer as to how to fix 
> THAT), and it panics saying Unable to mount root "" or 01:00. Some people 
> said try root=/dev/ide/[etc..] but that doesn't work, I want to boot the 
> initrd for the install, not a partition on the hard drive. Please, how can I 
> accomplish this?? Sorry if I'm being cranky but everyone has been driving me 
> nuts and treating me like dirt in the channels.

Would it be possible that noone that has actually read your messages (and
some will delete the message right away because of your script kiddie like
nick) knows the answer? Or that this could actually be a real bug that still
needs somebody to investigate it further to try to fix it? So you have two
choices:

1. wait for the fix to be done by someone else, i.e. wait one month or so
   and try again
2. fix it yourself

Best Regards,

- Arnaldo
