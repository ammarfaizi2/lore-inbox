Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268339AbTBYWYn>; Tue, 25 Feb 2003 17:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTBYWYn>; Tue, 25 Feb 2003 17:24:43 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:34314 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S268339AbTBYWYm>; Tue, 25 Feb 2003 17:24:42 -0500
Date: Tue, 25 Feb 2003 14:34:48 -0800
From: "'jw schultz'" <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: statistics for this mailinglist
Message-ID: <20030225223448.GA10713@pegasys.ws>
Mail-Followup-To: 'jw schultz' <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030225003325.GA5283@pegasys.ws> <001e01c2dd00$8574d480$3640a8c0@boemboem>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001e01c2dd00$8574d480$3640a8c0@boemboem>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 08:02:18PM +0100, Folkert van Heusden wrote:
> > And it wouldn't hurt to aggregate versions.  This is really
> > just a top-6 list.
> >  1]  476 Mutt (most common versions versions)
> >  2]   60 ELM [version 2.5 PL6]
> >  3]   55 Mulberry/2.2.1 (Linux/x86)
> >  4]   42 Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
> >  5]   42 Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
> >  6]   41 Ximian Evolution 1.2.1 (1.2.1-4)
> 
> Problem is: what part is version-information and what is name?
> For Mutt 1.0, ELM 3.6 it's clear; it's the number part.
> But what about:
> FlokEdit peanutbutterrelease
> FlokEdit RMDrelease

I would expect it to take a few regexes but so far $mta =~ s/\W.*$//
would do the trick to produce Mutt, ELM, Mulberry, Sylpheed,
Mew, Ximian and even FlokEdit.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
