Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131055AbRABM0l>; Tue, 2 Jan 2001 07:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131113AbRABM0b>; Tue, 2 Jan 2001 07:26:31 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:5646 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S131077AbRABM0U>; Tue, 2 Jan 2001 07:26:20 -0500
Date: Tue, 2 Jan 2001 12:55:45 +0100
From: Kurt Roeckx <Q@ping.be>
To: Gerold Jury <geroldj@grips.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
Message-ID: <20010102125545.A8981@ping.be>
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com> <3A514236.2000801@grips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <3A514236.2000801@grips.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 03:51:34AM +0100, Gerold Jury wrote:
> The ISDN changes for the HISAX drivers
> that came in since test12 have introduced a bug that causes a 
> AIEE-something and a complete kernel hang when i hangup the isdn line.
> I have reversed the patch for all occurences of INIT_LIST_HEAD in the 
> isdn patch part and it works for me now.
> 
> The relevant part is attached. Please back it out for 2.4.0.

I'm using the hisax driver too (build in), and it works perfectly
for me.


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
