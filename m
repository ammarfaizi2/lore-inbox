Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266816AbRGKWPF>; Wed, 11 Jul 2001 18:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266820AbRGKWOp>; Wed, 11 Jul 2001 18:14:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16399 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S266816AbRGKWOl>;
	Wed, 11 Jul 2001 18:14:41 -0400
Date: Wed, 11 Jul 2001 19:14:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Paul Jakma <paul@clubi.ie>
Cc: Helge Hafting <helgehaf@idb.hist.no>, "C. Slater" <cslater@wcnet.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <Pine.LNX.4.33.0107112310590.962-100000@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Paul Jakma wrote:
> On Wed, 11 Jul 2001, Helge Hafting wrote:
>
> > That seems completely out of question.  The structures a 2.4.7
> > kernel understands might be insufficient to express the setup
> > a future 2.6.9 kernel is using to do its stuff better.
>
> however, it might be handy if say you needed to upgrade a stable
> kernel due to a bug fix or security update.

One thing which always surprises me in this discussion
(it comes up about once a year, it seems) is that
nobody participating in this discussion ever starts
writing any code for it.

Is this a feature which is only wanted by people who
don't want to code, or is this just a signal that the
amount of trouble involved just isn't worth it?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

