Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCWH1p>; Fri, 23 Mar 2001 02:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbRCWH1g>; Fri, 23 Mar 2001 02:27:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:35332 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129855AbRCWH1W>; Fri, 23 Mar 2001 02:27:22 -0500
Date: Fri, 23 Mar 2001 04:04:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Michael Peddemors <michael@linuxmagic.com>
Cc: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2001, Michael Peddemors wrote:

> Here, Here.. killing qmail on a server who's sole task is running mail
> doesn't seem to make much sense either..

I won't defend the current OOM killing code.

Instead, I'm asking everybody who's unhappy with the
current code to come up with something better.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

