Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286806AbRLVQEb>; Sat, 22 Dec 2001 11:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286807AbRLVQEW>; Sat, 22 Dec 2001 11:04:22 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:52792 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S286806AbRLVQET>; Sat, 22 Dec 2001 11:04:19 -0500
Message-Id: <4.3.2.7.2.20011222075342.00c11e00@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 22 Dec 2001 08:03:51 -0800
To: Phil Howard <phil-linux-kernel@ipal.net>, linux-kernel@vger.kernel.org
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in
  Configure.help.
In-Reply-To: <20011222044742.A27630@vega.ipal.net>
In-Reply-To: <Pine.GSO.4.30.0112221113120.2091-100000@balu>
 <E16H9C4-0005ST-00@sites.inka.de>
 <Pine.GSO.4.30.0112221113120.2091-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:47 AM 12/22/01 -0600, Phil Howard wrote:
>I can understand your point about not jumping into something that will turn
>out (possibly) to be a big flop and cause new confusion.  However, I'd like
>to point out that any new idea will _never_ become adopted if everyone takes
>the position of "I'm not going to do it until most everyone else does first".

Let's make clear what we are talking about.  We are talking about making 
the change to the one place that will be exposed to the non-technical user, 
but not anywhere else (internal documentation, comments to the source code, 
output from /proc, userland programs).  In other words, the absolutely 
worst place in the GNU/Linux system to introduce new and confusing usage 
that is not widely used.

Get the hint?  Let's change usage FIRST in the places that don't have the 
exposure of a Help File to the general public, THEN consider making the 
change once the users (technical and non-) have had a chance to voice their 
opinion.

I don't know about y'all, but my non-technical clients have enough problems 
with the historical abbreviations and terminology without being thrown this 
curve.  Unless you can get the business community to cry out for the change 
(so that BSD, what's left of BeOS, and Microsoft make the change) this is a 
Bad Idea(tm).

Look, I agree that there is significant merit to KiB et. al., but the 
marketplace has not always selected that which is best.  That's the nature 
of the marketplace.

Stephen Satchell

