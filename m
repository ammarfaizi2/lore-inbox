Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRLUXQY>; Fri, 21 Dec 2001 18:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283766AbRLUXQP>; Fri, 21 Dec 2001 18:16:15 -0500
Received: from white.pocketinet.com ([12.17.167.5]:14294 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S281916AbRLUXQG>; Fri, 21 Dec 2001 18:16:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Stephen Satchell <list@fluent2.pyramid.net>,
        Rik van Riel <riel@conectiva.com.br>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Configure.help editorial policy
Date: Fri, 21 Dec 2001 15:07:22 -0800
X-Mailer: KMail [version 1.3.1]
Cc: David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011221134034.B11147@thyrsus.com> <4.3.2.7.2.20011221140707.00c0e290@10.1.1.42>
In-Reply-To: <4.3.2.7.2.20011221140707.00c0e290@10.1.1.42>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITEjlHVEqpQVwOLRo000003eb@white.pocketinet.com>
X-OriginalArrivalTime: 21 Dec 2001 23:14:26.0572 (UTC) FILETIME=[3C02FCC0:01C18A75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 December 2001 02:53 pm, Stephen Satchell wrote:
> At 07:17 PM 12/21/01 -0200, Rik van Riel wrote:
> >As a last point, we shouldn't forget about the inconsistent
> >way in which the marketing departments of hardware vendors
> >apply these units to their products. In many cases binary
> >and decimal units are mixed, leading to something which is
> >impossible to "get right".  Disk space would be one example
> >of this, but I'm sure there are more.
> >
> >regards,
> >
> >Rik
>
> OK, how about this silly suggestion:  DON'T USE ABBREVIATIONS IN
> DOCUMENTATION.

While pure reason suddenly made me realize that we really shouldn't use 
abbreviations in docs, thus rendering MiB vs MB moot, this still leaves 
us with another problem:

Gigs or Gibs? Kibbles or Kilos? You're still going to end up with 
confusion, because outside of the (limited number of) people who heard 
about this "international" standard, nobody knows what the heck a 
kibibyte is.
