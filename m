Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136116AbRDVNrZ>; Sun, 22 Apr 2001 09:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136119AbRDVNrP>; Sun, 22 Apr 2001 09:47:15 -0400
Received: from marine.sonic.net ([208.201.224.37]:3337 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S136116AbRDVNq6>;
	Sun, 22 Apr 2001 09:46:58 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Sun, 22 Apr 2001 06:46:55 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3+ sound distortion
Message-ID: <20010422064655.A5682@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01042118044700.01268@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <01042118044700.01268@victor>; from v.p.p.julien@let.rug.nl on Sat, Apr 21, 2001 at 06:04:47PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 06:04:47PM +0200, Victor Julien wrote:
> I have a problem with kernels higher than 2.4.2, the sound distorts when 
> playing a song with xmms while the seti@home client runs. 2.4.2 did not have 

Would this be the same issue as describe in these threads:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.0/0233.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.1/0231.html

That is, the change in how nice is recalculated.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
