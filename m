Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264238AbRFFXKZ>; Wed, 6 Jun 2001 19:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264237AbRFFXKP>; Wed, 6 Jun 2001 19:10:15 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:55818 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264238AbRFFXKA>; Wed, 6 Jun 2001 19:10:00 -0400
Date: 07 Jun 2001 00:44:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <82PkVOimw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>
Subject: Re: Break 2.4 VM in five easy steps
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010606112207.H15199@dev.sportingbet.com> <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 06.06.01 in <Pine.GSO.4.21.0106060637580.7264-100000@weyl.math.psu.edu>:

> On Wed, 6 Jun 2001, Sean Hunter wrote:
>
> > This is completely bogus. I am not saying that I can't afford the swap.
> > What I am saying is that it is completely broken to require this amount
> > of swap given the boundaries of efficient use.
>
> Funny. I can count many ways in which 4.3BSD, SunOS{3,4} and post-4.4 BSD
> systems I've used were broken, but I've never thought that swap==2*RAM rule
> was one of them.

As a "will break without" rule, I'd consider a kernel with that property  
completely unsuitable for production use. I certainly don't remember  
thinking of that as more than a recommendation back when I used commercial  
Unices (SysVsomething).

MfG Kai
