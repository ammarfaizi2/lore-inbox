Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbSKPVkY>; Sat, 16 Nov 2002 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267378AbSKPVkY>; Sat, 16 Nov 2002 16:40:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7622 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267373AbSKPVkW>; Sat, 16 Nov 2002 16:40:22 -0500
Date: Sat, 16 Nov 2002 13:44:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <551278547.1037454258@[10.10.2.3]>
In-Reply-To: <20021116214140.GP24641@conectiva.com.br>
References: <20021116214140.GP24641@conectiva.com.br>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Very bad idea. People using unusual hardware do not want to keep
>> re-submitting a bug report. I know when I submit a report I expect 
>> that it will remain until the problem is fixed. I do not like to 
>> receive multiple
> 
> Oh well, there is _no_ guarantee that it will be fixed, sometimes 
> there is no  maintainer at all and the ticket will stay there forever 
> lost in the noise...
> And if anybody is interested in fixing the driver or even looking to 
> see if somebody submitted a ticket he/she can just search for all 
> tickets, even the ones closed because nobody is did any activity in 
> a perior of one month (or any other timeout period).
> 
> Its not like the ticket will vanish from the database.

One thing we've done before in other bug-tracking systems was to create
a "STALE" state (or something similar) for this type of bug. So it 
wouldn't get closed (I have seen this done as a closing resolution, but
I think that's a bad idea), but it wouldn't be in the default searches
either ... you could just select it if you wanted it ... does that sound
sane? (obviously we don't need this yet, but might be a good plan
longer-term).

M.

