Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbQKEXLR>; Sun, 5 Nov 2000 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129928AbQKEXLF>; Sun, 5 Nov 2000 18:11:05 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:42609 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129813AbQKEXKw>;
	Sun, 5 Nov 2000 18:10:52 -0500
Message-ID: <3A05E7A1.C97B85D9@Rikers.org>
Date: Sun, 05 Nov 2000 16:05:05 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9vaio i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Lehmann <pcg@goof.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux?
In-Reply-To: <E13s11X-0004TQ-00@the-village.bc.nu> <3A05C888.7558E0F0@Rikers.org> <20001105160637.Z6207@devserv.devel.redhat.com> <20001105234225.J443@cerebro.laendle>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann wrote:
> 
> On Sun, Nov 05, 2000 at 04:06:37PM -0500, Jakub Jelinek <jakub@redhat.com> wrote:
> > That's hard to do, because the whole gcc has copyright assigned to FSF,
> > which means that either gcc steering committee would have to make an
> > exception from this
> 
> Which can not and will not happen.

I understand "will not", but "can not"? There is nothing stopping
anyone, let's say SGI for example, from branching a separate gcc which
would include copyrights assigned to FSF and other parties. Let's say
this happens and a new sgigcc source base is created. Presumably then
any defense of gcc code could be met with the argument that the code
used came from sgigcc. This being the case what has the FSD gained by
the current policy?

I suppose that this is even the case today as one could argue that code
came from intel-gcc if they used the Intel patches for ia64 or any other
non-FSF copyrighted patches including patches made by the same company
that the FSD might be in legal action with.

In short, I do not see any enforceable advantages to the current FSF
policies.

> > for SGI, or SGI would have to be willing to assign some code to FSF.
> 
> Which is the standard procedure that the FSF requires for all it's
> programs to be able to defend them - incorporating non-assigned code into
> gcc creates some intractable problems (i.e.: make it impossible) when the
> FSD ever wanted to go to court to defend the freedom of gcc.

Statements above are my own, and I am not a lawyer.

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
