Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132427AbRDCTbU>; Tue, 3 Apr 2001 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRDCTbL>; Tue, 3 Apr 2001 15:31:11 -0400
Received: from phoenix.nanospace.com ([209.213.199.121]:5906 "HELO
	phoenix.nanospace.com") by vger.kernel.org with SMTP
	id <S132427AbRDCTay>; Tue, 3 Apr 2001 15:30:54 -0400
Date: Tue, 3 Apr 2001 12:30:14 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
Message-ID: <20010403123014.A17132@thune.yy.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com> <20010403161322.A8174@werewolf.able.es> <3ACA1A91.70401@kalifornia.com> <20010403211218.A2387@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <20010403211218.A2387@werewolf.able.es>; from jamagallon@able.es on Tue, Apr 03, 2001 at 09:12:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 09:12:18PM +0200, J . A . Magallon wrote:
> Just like the Alan Cox for 2.4 or Andrea Arcangeli for 2.2. Lets say you
> have 2.4.2-ac27. For each of your compiles, set EXTRAVERSION to -ac27-bf1,
> -ac27-bf2, etc. Your files will be:

Some patches, such as the RAID patches, sets up EXTRAVERSION to a specific
value.

I do with the make file also had a USERVERSION that would be hands off for
anyone but the builder.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
