Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCWBn4>; Thu, 22 Mar 2001 20:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCWBnp>; Thu, 22 Mar 2001 20:43:45 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51216 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129143AbRCWBni>; Thu, 22 Mar 2001 20:43:38 -0500
Date: Thu, 22 Mar 2001 22:37:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3C9BDAC7.4B499AD1@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0103222236450.29682-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Martin Dalecki wrote:

> This is due to the broken calculation formula in oom_kill().

Feel free to write better-working code.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

