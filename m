Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292399AbSCDQAg>; Mon, 4 Mar 2002 11:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292423AbSCDQAQ>; Mon, 4 Mar 2002 11:00:16 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:28325 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292399AbSCDQAJ>; Mon, 4 Mar 2002 11:00:09 -0500
Date: Mon, 4 Mar 2002 17:00:07 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.94] Fifth test release of Tigon3 driver
Message-ID: <20020304170007.A1648@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020304.041252.13772021.davem@redhat.com> <20020304164453.A27587@stud.ntnu.no> <3C83993A.94FE655E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C83993A.94FE655E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 04, 2002 at 10:56:42AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik:
> A comparison between bcm5700 and tg3 would be interesting, for each new
> release, if you were willing to do that.

Ok, sure :)   We're going to switch our fileserver as soon as this goes into
mainstream-kernel, so I'm always happy to help with the testing to get the
best possible driver :)

> And, what MTU are you using?  You may have answered this earlier and I
> forgot :)  If you -are- on a gigabit network, then you [currently] must
> manually enable an MTU of 9000 (jumbo frames).

Ok, I'll try with jumbo frames; and with the bcm5700 driver and come back
with results in abit.

-- 
Thomas
