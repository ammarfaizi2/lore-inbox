Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267046AbRGNAb7>; Fri, 13 Jul 2001 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267055AbRGNAbt>; Fri, 13 Jul 2001 20:31:49 -0400
Received: from weta.f00f.org ([203.167.249.89]:18819 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267046AbRGNAbk>;
	Fri, 13 Jul 2001 20:31:40 -0400
Date: Sat, 14 Jul 2001 12:31:41 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
Message-ID: <20010714123141.A6119@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0107131946410.3892-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0107131946410.3892-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 07:53:12PM -0300, Marcelo Tosatti wrote:

    Maybe. Personally I don't really care about the way we are doing
    this, as long as I can get the information. I can add /proc/vmstat
    easily if needed...

How about something under advance kernel hacking options of wherever
the sysrq options is? (and profiling used to live, before it was
always there), or, since the code is rather small, we could perhaps
always have this available.

    Well, I don't want to include this stuff on the stock vmstat code
    right now. I've done an ugly hack in vmstat.c to get the thing to
    work and thats it.

Fair enough, but the comment "please apply" makes me nervous then :)



  --cw
