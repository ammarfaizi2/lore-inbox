Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRFGOAY>; Thu, 7 Jun 2001 10:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRFGOAE>; Thu, 7 Jun 2001 10:00:04 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62886 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262614AbRFGOAA>;
	Thu, 7 Jun 2001 10:00:00 -0400
Message-ID: <3B1F7130.94357A3C@compro.net>
Date: Thu, 07 Jun 2001 08:18:56 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pset patch??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Sorry if this is off topic. I've searched the archives and found
references to
what I'm looking for but the URL's take me nowhere. The references I'm
referring to
are for pset patches that will enable me to lock down a processor in an
smp env.
Lock down meaning I need to be able to lock out all system interrupts
and tasks from
a defined cpu and lock in a particular task/tasks and set of external
interrupts to
that same cpu. Yes it's for a real time app but not sure if rtlinux is
what I am
in need of.
 
I see references to this site http://isunix.it.ilstu.edu/~thockin/pset/.
>From reading the archives it looks like what I'm looking for but there
is nothing there.

Is what I need to do possible and if I need this patch do to it could
someone tell
me where I might find it? Sorry if this is OT but I'm at a dead end road
and didn't
know where else to ask??  Thanks in advance.

Mark Hounschell
