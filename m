Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbSJCTqk>; Thu, 3 Oct 2002 15:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSJCTqk>; Thu, 3 Oct 2002 15:46:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45523 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261291AbSJCTqk>; Thu, 3 Oct 2002 15:46:40 -0400
Date: Thu, 3 Oct 2002 16:51:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: jbradford@dial.pipex.com, <jgarzik@pobox.com>, <kessler@us.ibm.com>,
       <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <saw@saw.sw.com.sg>, <rusty@rustcorp.com.au>,
       <richardj_moore@uk.ibm.com>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
 logging macros, SCSI RAIDdevice)
In-Reply-To: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0210031650000.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Linus Torvalds wrote:

> The memory management issues would qualify for 3.0, but my argument
> there is really that I doubt everybody really is happy yet.

I'm absolutely convinced some people won't be happy, simply
because of the fundamental limitations of global page replacement.
However, Andrew Morton has done a great job and the 2.5 VM seems
to be looking as good as anything we've had before.

For me 3.0 arguments would be Ingo's threading stuff, not anything
else.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

