Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVGTOIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVGTOIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVGTOIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:08:20 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:33676 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261231AbVGTOIT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:08:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h+KMfOYQFy6qWtzioev24DnRUOFx1V70qZoiJB2KhG+7dNlA8q2KSa3xyMTeV4lq3VKWagcp9KtPpw32bx0Ks/FLeDSnyBliq30fSVXR/f0bX1HqH2eo6jqzsUqNAhqYf08odI2np13FUBPWH1oEWgNQEGU52xbH2NfINv98aKs=
Message-ID: <9a87484905072007075a9b0bba@mail.gmail.com>
Date: Wed, 20 Jul 2005 16:07:45 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: eliad lubovsky <eliadl@013.net>
Subject: Re: Linux Benchmarks
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121866937.3251.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1121866937.3251.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, eliad lubovsky <eliadl@013.net> wrote:
> Where can I find common Linux benchmarks? I added some changes to system
> calls and want to check whether it cause any performance degradation.
> Thanks,
> 
You could go search Google - http://google.com/ 
You could go search Freshmeat - http://freshmeat.net/ 
You could go search almost any Linux software archive...

Luckily for you I'm a bit bored and have 2min to spare, so I'll list a
few for you, but in the future, please try finding them yourself
first...

aiostress
  ftp://ftp.suse.com/pub/people/mason/utils/aio-stress.c

bonnie
  http://www.garloff.de/kurt/linux/bonnie/

clyde
  http://tdec.free.fr/clyde/clyde.en.html

contest
  http://contest.kolivas.org/
  
dbench
  http://samba.org/ftp/tridge/dbench/

interbench
  http://interbench.kolivas.org/

iozone
  http://www.iozone.org/

lmbench
  http://www.bitmover.com/lmbench/

nbench
  http://www.tux.org/~mayer/linux/bmark.html

netperf
  http://www.netperf.org/

re-aim
  http://sourceforge.net/projects/re-aim-7

sysbench
  http://sysbench.sourceforge.net/

tbench
  http://gnunet.org/doxygen/html/dir_000026.html

volanomark
  http://www.volano.com/benchmarks.html


And there's plenty more to be found out there on the 'net if need be...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
