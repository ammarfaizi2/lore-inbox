Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUAaHQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUAaHQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:16:29 -0500
Received: from hb6.lcom.net ([216.51.236.182]:1164 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S262746AbUAaHQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:16:27 -0500
Date: Sat, 31 Jan 2004 01:16:22 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Luke-Jr <luke7jr@yahoo.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
Message-ID: <20040131071619.GD7245@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Luke-Jr <luke7jr@yahoo.com>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1075436665.2086.3.camel@laptop-linux> <200401310622.17530.luke7jr@yahoo.com> <1075531042.18161.35.camel@laptop-linux> <20040131064757.GB7245@digitasaru.net> <1075532166.17727.41.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075532166.17727.41.camel@laptop-linux>
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

'ello.

>On Sat, 2004-01-31 at 19:48, Joseph Pingenot wrote:
>> Coupla quick questions for you, while we're on the topic.
>> 
>> I get lots of fails against 2.6.2-rc2-mm1; will the -rcX kernels
>>   be addressed, or will the patches only be against non-rc kernels?
>>   What about -mm kernels?
>
>In the past I have only done patches against the 2.6.x kernels. I'm
>thinking, however, of requesting space on kernel.org for patches against
>-rcX and -mm kernels. You're the second person to ask. If I get asked

That'd rock.  It's a very important thing nowadays.

>some more, I might do it :> (It's not that it's hard, just that it takes

Hmm.  Do I have to be a *new* person to ask, or can I just keep
  asking until you give in?  ;)

>time and today is my last day working on the code full time).

Oi!  I'll give you five (US) dollars.  Is that near enough?  :)

Actually, in all seriousness, is there some sort of tips place
  to give you money to fund the project?  Although I don't have
  much time (working on yet another cpu governor, amongst other
  things), I can not eat at a restauraunt for lunch a couple of
  times and send the money your way.  :)

>> Also, how does this differ from what is currently in the vanilla
>>   kernels?
>The best way to answer that is to point to
>http://swsusp.sourceforge.net/features.html.

Ah.  Thankye.

A few last questions while I'm at it.  (I'm struggling to get it to work
  with my new Dell Inspiron 8600.)  Is it alright to have the different
  swsus/pmdisk versions enabled in the same kernel?  Finally, is there
  any specific way to create the swap space for saving the state to?
  I created a swap partition (/dev/hda8 fwiw), made it type 82 and
  ran mkswap on it.  However, after I tried to suspend, it didn't
  recognize the saved data.

-Joseph
