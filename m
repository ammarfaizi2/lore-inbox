Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRAINly>; Tue, 9 Jan 2001 08:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbRAINlp>; Tue, 9 Jan 2001 08:41:45 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:32231 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130013AbRAINl3>; Tue, 9 Jan 2001 08:41:29 -0500
Message-ID: <3A5B168B.A5CCA889@uow.edu.au>
Date: Wed, 10 Jan 2001 00:47:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Stephen Landamore <stephenl@zeus.com>, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.10.10101091301170.18208-100000@phaedra.cam.zeus.com> <Pine.LNX.4.30.0101091418300.3375-100000@e2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Stephen Landamore wrote:
> 
> > >> Sure.  But sendfile is not one of the fundamental UNIX operations...
> 
> > > Neither were eg. kernel-based semaphores. So what? Unix wasnt
> 
> > Ehh, that's not correct. HP-UX was the first to implement sendfile().
> 
> i dont think we disagree. What i was referring to was the 'original' Unix
> idea, the 30 years old one, which did not include sendfile() :-) We never
> claimed that sendfile() first came up in Linux [that would be a blatant
> lie] - and the Linux API itself was indeed influenced by existing
> sendfile()/copyfile() interfaces. (at the time Linus implemented
> sendfile() there already existed several similar interfaces.)
> 

y'know our pals have patented it?

http://www.delphion.com/details?pn=US05845280__
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
