Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSIBXj1>; Mon, 2 Sep 2002 19:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSIBXj1>; Mon, 2 Sep 2002 19:39:27 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:15772 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S318599AbSIBXj0>; Mon, 2 Sep 2002 19:39:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 2 Sep 2002 16:48:08 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Stupid anti-spam testings...
In-Reply-To: <20020902233230.GC5834@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0209021645250.1614-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Matti Aarnio wrote:

> On Mon, Sep 02, 2002 at 04:28:37PM -0600, Andreas Dilger wrote:
> ...
> > > Folks,  when you deploy that kind of testers, DO VERIFY THAT THEY
> > > HAVE SANE CACHES!  A positive result shall be cached for at least
> > > two hours, a negative result shall be cached for at least 30 minutes.
> >
> > Do you know if this is one of the default checks from spamassassin?
>
>   No idea.  I have seen these coming from Exim 4.10, Exim-something,
>   some sendmail milter (whatever that is), etc..
>
>   Apparently the idea (which I have thought of long ago, and rejected
>   as incomplete) has caught, and has multiple implementations...

Personally i don't think this kind of tests are going to reduce the spam
that much but a simple lookup in the subscribers database might help
reducing the smtp-test traffic only for non-subscriber addresses.



- Davide


