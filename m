Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154482-24313>; Tue, 25 Aug 1998 08:19:02 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:13608 "HELO mail.ocs.com.au" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154542-24313>; Tue, 25 Aug 1998 07:11:03 -0400
Message-ID: <19980825124627.12622.qmail@mail.ocs.com.au>
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@dm.cobaltmicro.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Fuzzy hash stuff.. (was Re: 2.1.xxx makes Electric Fence 22x slower) 
In-reply-to: Your message of "Tue, 25 Aug 1998 01:33:14 MST." <199808250833.BAA32289@dm.cobaltmicro.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Aug 1998 22:47:26 +1000
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, 25 Aug 1998 01:33:14 -0700, 
"David S. Miller" <davem@dm.cobaltmicro.com> wrote:
>As promised here is my work in progress fuzzy hash VMA lookup stuff.
>
>The fuzzy hashing scheme used here was first formulated by Thomas
>Schoebel, I fixed all the minor quirks and bugs in his initial
>formulation and together we converged on the algorithm as used here.

Lots of code with very few comments snipped.  Come on Davem, make it
understandable for us mere mortals.  If it took two people to fix
quirks and bugs and converge the algorithm, surely a few notes on how
it works would not go astray.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
