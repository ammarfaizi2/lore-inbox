Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUDUOkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUDUOkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbUDUOkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:40:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263040AbUDUOkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:40:05 -0400
Date: Wed, 21 Apr 2004 10:39:52 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Miles Bader <miles@gnu.org>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Jan De Luyck <lkml@kcore.org>,
       <linux-kernel@vger.kernel.org>, <postmaster@vger.kernel.org>
Subject: Re: vger.kernel.org is listed by spamcop
In-Reply-To: <buoad15hfp2.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0404211034280.1735-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Apr 2004, Miles Bader wrote:

> The spamcop report page seems to say that the listings are due to user
> reports; could the real problem be clueless users who don't understand
> the difference above?

Absolutely.  While most of the spamcop administrators
seem pretty smart, their system definitely is vulnerable
to the "Garbage In, Garbage Out" principle.

I'm certain than vger got listed on spamcop due to
linux-kernel subscribers reporting to spamcop some of
the spam that leaked onto lkml, through Matti's strict
filters.

I wouldn't be surprised if some of those same users
were now complaining they couldn't get their linux-kernel
email. ;)

In my opinion, there are only two types of anti-spam lists
that can be responsibly used:
- lists run by people smart enough to recognise
  that they make mistakes and are willing to
  correct them whenever they happen
- lists run in an entirely automated fashion, with
  no human input whatsoever -- but only when the
  software is administrated by people willing to
  correct problems that happen

Lists that take the philosophy of "sorry that was our
mistake, but we're still not going to make an exception"
probably aren't the right lists to use if you care about
your email.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

