Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274634AbRJJED6>; Wed, 10 Oct 2001 00:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJJEDv>; Wed, 10 Oct 2001 00:03:51 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:52239 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274634AbRJJEDe> convert rfc822-to-8bit; Wed, 10 Oct 2001 00:03:34 -0400
Subject: Re: 2.4.10-ac10-preempt lmbench output.
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1002686542.866.164.camel@phantasy>
In-Reply-To: <200110100358.f9A3wSB17421@zero.tech9.net> 
	<1002686542.866.164.camel@phantasy>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 10 Oct 2001 00:04:42 -0400
Message-Id: <1002686685.1243.170.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 00:02, Robert Love wrote:
> On Tue, 2001-10-09 at 23:57, Dieter Nützel wrote:
> > Robert you are running a dual PIII system, right?
> > Could that be the ground why you aren't see the hiccup with your nice preempt
> > patch? Are you running ReiserFS or EXT2/3?
> 
> No, I am on a single P3-733.  I am using ext3.

Oh, I'm not using Linus's tree, either.

Right now I am 2.4.10-ac10 + preempt-kernel + Rik's eatcache

	Robert Love

