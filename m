Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVJLJ5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVJLJ5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJLJ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:57:08 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:17416 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751348AbVJLJ5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:57:07 -0400
From: Felix Oxley <lkml@oxley.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Linux Kernel Dump Summit 2005
Date: Wed, 12 Oct 2005 10:56:46 +0100
User-Agent: KMail/1.8.2
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
References: <20051010084535.GA2298@elf.ucw.cz> <200510121002.59098.lkml@oxley.org> <20051012090945.GN12682@elf.ucw.cz>
In-Reply-To: <20051012090945.GN12682@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121056.48429.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for helping a clueless newbie :-)

> Notice that suspend2 project actually introduced compression *for
> speed*. Doing it right means that it is faster to do it
> compressed. 

I see! 
Little benchmarks here: http://wiki.suspend2.net/BenchMarks
shows 15% speed _increase_ with compression.

> See Jamie Lokier's description how to *never* slow down. 
Sorry, where is this?

So, if compression is a no-brainer then it is just necessary for the user to 
select: no dump. partial dump or full dump suitable for there circumstances?
Can this be set from user-space?

regards,
Felix
