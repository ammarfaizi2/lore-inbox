Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbSJWB4r>; Tue, 22 Oct 2002 21:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJWB4r>; Tue, 22 Oct 2002 21:56:47 -0400
Received: from dp.samba.org ([66.70.73.150]:2540 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262689AbSJWB4q>;
	Tue, 22 Oct 2002 21:56:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       richard <richardj_moore@uk.ibm.com>, suparna@in.ibm.com,
       bharata <bharata@in.ibm.com>, tom <hanharat@us.ibm.com>
Subject: Re: [patch 1/4] kprobes - base for 2.5.44 
In-reply-to: Your message of "22 Oct 2002 13:43:29 +0200."
             <1035287010.3002.4.camel@localhost.localdomain> 
Date: Wed, 23 Oct 2002 11:07:54 +1000
Message-Id: <20021023020256.A03CE2C068@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1035287010.3002.4.camel@localhost.localdomain> you write:
> On Tue, 2002-10-22 at 13:09, Vamsi Krishna S . wrote:
> > Here is the basic kprobes patch for 2.5.44. It is the same patch that
> > Rusty has been sending out since a while, just ported up to 2.5.44.
> 
> I also would like to thank you personally for the consideration and
> courtesy of resending a patch series patch as a thread instead of just
> spewing linux-kernel.

[ How do you do that?  I've never done that, and it'd be kind of
neat. ]

> Oh and thank you for the major changes above just
> porting to 2.5.44.

These major changes must have been subtle, since I missed them.

>                 NOT

I'll try to translate from socially-retarted elitist-speak into
English:

================
On 22 Oct 2002 13:43:29 +0200, Arjan van de Ven should have written:
> Hi Vamsi,
> 
>    Two immediate comments on your patch: it's easier to follow if
> you send it as one thread, rather than disconnected posts, and there
> seem to be large changes between <last time I read them> and now,
> such as <xxx>, which are not simply porting to 2.5.44.  I'm not sure
> I follow.
>
> Arjan.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
