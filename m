Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131003AbQLUWuE>; Thu, 21 Dec 2000 17:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbQLUWtz>; Thu, 21 Dec 2000 17:49:55 -0500
Received: from monza.monza.org ([209.102.105.34]:8197 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131003AbQLUWtp>;
	Thu, 21 Dec 2000 17:49:45 -0500
Date: Thu, 21 Dec 2000 14:19:08 -0800
From: Tim Wright <timw@splhi.com>
To: Paul Cassella <pwc@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001221141908.D1350@scutter.sequent.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Paul Cassella <pwc@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A42380B.6E9291D1@sgi.com> <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.3.96.1001221130859.8463C-100000@fsgi626.americas.sgi.com>; from pwc@sgi.com on Thu, Dec 21, 2000 at 01:30:03PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.
I'd like to play with you patch, but certainly from a first glance, it would
seem to be sufficiently powerful, and significantly cleaner/clearer (at least
to me :-) than the current mechanism involving the wait queue games.

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
