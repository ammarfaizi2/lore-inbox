Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266834AbRGKWhe>; Wed, 11 Jul 2001 18:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbRGKWhZ>; Wed, 11 Jul 2001 18:37:25 -0400
Received: from woodyjr.wcnet.org ([63.174.200.2]:17140 "EHLO woodyjr.wcnet.org")
	by vger.kernel.org with ESMTP id <S266834AbRGKWhH>;
	Wed, 11 Jul 2001 18:37:07 -0400
Message-ID: <002201c10a59$e5ef0ae0$7fcdae3f@laptop>
From: "C. Slater" <cslater@wcnet.org>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>
Subject: Re: Switching Kernels without Rebooting?
Date: Wed, 11 Jul 2001 18:36:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it come up often? Well, I have a sourceforge project setup and am
currently only waiting on finalizing how it's going to be done. So we have
about proved the first possibility wrong, and if you ever hear anything else
about this in a while, we will have proved the second wrong too. Soo, while
we are at it, ill say, that if anyone wants to help with it, email me. We
especialy need people that either have ideas on how to do this or have a
good knowledge of the kernel, mainly memory, processes, and initilization.

  Colin

----- Original Message -----
From: Rik van Riel <riel@conectiva.com.br>
To: Paul Jakma <paul@clubi.ie>
Cc: Helge Hafting <helgehaf@idb.hist.no>; C. Slater <cslater@wcnet.org>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, July 11, 2001 06:14 PM
Subject: Re: Switching Kernels without Rebooting?


> On Wed, 11 Jul 2001, Paul Jakma wrote:
> > On Wed, 11 Jul 2001, Helge Hafting wrote:
> >
> > > That seems completely out of question.  The structures a 2.4.7
> > > kernel understands might be insufficient to express the setup
> > > a future 2.6.9 kernel is using to do its stuff better.
> >
> > however, it might be handy if say you needed to upgrade a stable
> > kernel due to a bug fix or security update.
>
> One thing which always surprises me in this discussion
> (it comes up about once a year, it seems) is that
> nobody participating in this discussion ever starts
> writing any code for it.
>
> Is this a feature which is only wanted by people who
> don't want to code, or is this just a signal that the
> amount of trouble involved just isn't worth it?
>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> http://www.surriel.com/ http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)

