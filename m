Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLSPvo>; Tue, 19 Dec 2000 10:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbQLSPvf>; Tue, 19 Dec 2000 10:51:35 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:38532 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129183AbQLSPv2>; Tue, 19 Dec 2000 10:51:28 -0500
Message-ID: <3A3F7C7C.988458AF@inet.com>
Date: Tue, 19 Dec 2000 09:19:24 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@linuxcare.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: generic sleeping locks?
In-Reply-To: <E148AIe-0000UM-00@halfway>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3A3E98E9.F68BC13A@inet.com> you write:
> > Alan Cox wrote:
> > >
> > > > Are there blocking lock primitives already defined somewhere in the
> > > > kernel?
> > >
> > > down and up are normally appropriate for this
> >
> > Ungh.  Forest.  Trees.  *sigh*  Sorry for the dumb question.
> > Thanks for the reply Alan.  :)
> >
> > Ok, second part of the question:  What about blocking read/write locks
> > (with _interruptible variants)?
> 
> Documentation/DocBook/kernel-locking*
> 
> Rusty.
> --
> Hacking time.

Perhaps I should have specified that I'm working with 2.2.xy....
I'll d/l a 2.4.0-test and look at the docbook in that.  Thanks for the
pointer.

Eli 
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
