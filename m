Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUAaGsF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 01:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUAaGsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 01:48:05 -0500
Received: from hb6.lcom.net ([216.51.236.182]:58763 "EHLO localhost")
	by vger.kernel.org with ESMTP id S263453AbUAaGsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 01:48:03 -0500
Date: Sat, 31 Jan 2004 00:48:00 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
Message-ID: <20040131064757.GB7245@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Luke-Jr <luke7jr@yahoo.com>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075531042.18161.35.camel@laptop-linux>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Nigel Cunningham on Saturday, 31 January, 2004:
>Hi.
>On Sat, 2004-01-31 at 19:22, Luke-Jr wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> Except that it doesn't seem to work...
>> 1. patched in software-suspend-core-2.0-whole -- worked fine
>> 2. software-suspend-linux-2.6.1-rev3-whole:
>> 	2a. can't autodetect files to patch
>> 	2b. alot of patching fails
>> 
>> Is there something obvious I'm doing wrong? :/
>Yes. Apply the patches the other way around - the version specific one
>first, then the core. Oh, you'll also want to get the latest 2.6.1 patch
>(http://swsusp.sf.net).

Coupla quick questions for you, while we're on the topic.

I get lots of fails against 2.6.2-rc2-mm1; will the -rcX kernels
  be addressed, or will the patches only be against non-rc kernels?
  What about -mm kernels?

Also, how does this differ from what is currently in the vanilla
  kernels?

Thanks!
