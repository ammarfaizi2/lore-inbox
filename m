Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265752AbUBCBFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUBCBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:04:47 -0500
Received: from hb6.lcom.net ([216.51.236.182]:27009 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S265647AbUBCBDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:03:05 -0500
Date: Mon, 2 Feb 2004 19:03:01 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: "Brown, Len" <len.brown@intel.com>
Cc: bluefoxicy@linux.net, linux-kernel@vger.kernel.org
Subject: Re: ACPI -- Workaround for broken DSDT
Message-ID: <20040203010258.GC6376@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>, bluefoxicy@linux.net,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Brown, Len on Sunday, 01 February, 2004:
>The vendor should supply a correct DSDT with their BIOS.
>In the case of Dell, you might inquire here: http://linux.dell.com/
>For non-vendor supplied solutions, you might also follow the DSDT link
>here: http://acpi.sourceforge.net/  

Hmm.  Do vendors generally release these?  I know Dell's very shaky on
  the Linux support front, at least for desktop/laptop.
Also, how do non-vendor supplied ones get made?  Seems like something
  you need NDA'ed docs for.

-Joseph

>> >this is probably best addressed to acpi-devel@lists.sourceforge.net
>> >where people over-ride their BIOS ACPI DSDT all the time.
>> >However, there is a reason that it isn't push-button, and that is
>> >because we don't want to encourage people to do it.  We'd rather fix
>> >Linux where Linux is broken, or get the OEMs to fix their 
>> BIOS where the
>> >BIOS is broken.
>> How does one get a hold of a fixed DSDT?  I've seen postings about
>>   how to apply them, but how do they get released?  I'd *love* for
>>   Dell to release a fix for my Inspiron 8600 (haven't found a fixed
>>   DSDT), or to just get a hold of one.
>> *sigh*  When will the vendors support Linux?!
