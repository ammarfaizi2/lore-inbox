Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135897AbREFW0p>; Sun, 6 May 2001 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135896AbREFW0f>; Sun, 6 May 2001 18:26:35 -0400
Received: from idiom.com ([216.240.32.1]:45574 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S135898AbREFW0S>;
	Sun, 6 May 2001 18:26:18 -0400
Message-ID: <3AF5EA03.5D92B2E6@namesys.com>
Date: Sun, 06 May 2001 17:19:16 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dirk Mueller <dmuell@gmx.net>
CC: Chris Mason <mason@suse.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] ReiserFS seems to be stable as of 2.4.4
In-Reply-To: <20010504182357.A20214@rotes20.wohnheim.uni-kl.de> <341650000.988994279@tiny> <20010504192348.A11507@rotes20.wohnheim.uni-kl.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk Mueller wrote:

>
> Now consider a good amount of fragmentation because those files get created
> over time (weeks, months etc). and you quickly degenerade to a scanning
> speed of maybe 10-20 files per second (Athlon 800, IBM 60GB HD with roughly
> 35MB/s linear read). It was that horrible that I quickly returned to mbox
> for those lists with high amount of traffic.

I think only a repacker can properly cure performance problems of slowly
accumulating files and directories .  September 2002.

We can do other things that will gain 5 percent here and there, but the repacker
will be the real cure.

Hans

