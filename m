Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRC0XFH>; Tue, 27 Mar 2001 18:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131889AbRC0XE6>; Tue, 27 Mar 2001 18:04:58 -0500
Received: from 5-026.cwb-adsl.telepar.net.br ([200.193.164.26]:8720 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S131730AbRC0XEk>; Tue, 27 Mar 2001 18:04:40 -0500
Date: Tue, 27 Mar 2001 19:57:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Richard Jerrell <jerrell@missioncriticallinux.com>
cc: Stephen Tweedie <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
In-Reply-To: <Pine.LNX.4.21.0103271807010.1989-200000@jerrell.lowell.mclinux.com>
Message-ID: <Pine.LNX.4.21.0103271956420.8261-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Richard Jerrell wrote:

> Oops... I sent out the wrong version of the patch the first time.  
> This one has comments, promise.  And it has one less bug.  :)

Looks good to me (at first glance).  Any volunteer to
stress-test this on an SMP machine ?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

