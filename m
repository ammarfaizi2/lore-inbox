Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbTEGBFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTEGBFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:05:46 -0400
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:30692 "EHLO
	ubb.apia.dhs.org") by vger.kernel.org with ESMTP id S262520AbTEGBFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:05:45 -0400
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
To: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
References: <20030506165014$3d57@gated-at.bofh.it> <20030506193019$0d29@gated-at.bofh.it> <20030506220018$5b96@gated-at.bofh.it>
Organization: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
User-Agent: MT-NewsWatcher/3.1 (PPC)
Date: Tue, 06 May 2003 20:17:56 -0500
Message-ID: <nicoya-B9CA30.20175606052003@news.pp.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030506220018$5b96@gated-at.bofh.it>,
 Jamie Lokier <jamie@shareable.org> wrote:

: I do not see any practical alternative way to create a new kind of
: operating system kernel that is compatible with the wide range of PC
: hardware, other than:
: 
:   (a) read lots of open source code and then write drivers,
:       filesystems etc. from what is learned, or
:   (b) just use the available code with appropriate wrapping.
: 
: Both are lots of work.  But isn't (b) going to be less work?  I'm not
: sure.

If your interest is in creating a new and unique OS, you'll likely find that it 
becomes a great deal of work to try to glue the linux drivers into it.

I would imagine in the majority of cases you'd either have to change the driver 
code considerably to fit the subtleties of <newos>, or change the <newos> code 
considerably to fit the subtleties of linux.

When creating a new system, the last thing you want to have to do is carry 
around a bunch of extra baggage that you really don't need.

Anyways, this is 2003, aren't operating systems supposed to be boring by now? 
And where's my flying car damnit. ;)


To answer your question more directly, I think most developers would agree that 
the spirit of the GPL is "give as you take". If just releasing back the source 
to the modified drivers - completely useless without your new closed kernel - 
doesn't feel a whole lot like "giving", then you're probably not doing enough to 
keep people happy.


Cheers - Tony 'Nicoya' Mantler :)

-- 
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/
