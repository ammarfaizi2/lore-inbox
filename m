Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129516AbQKZUGh>; Sun, 26 Nov 2000 15:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKZUG1>; Sun, 26 Nov 2000 15:06:27 -0500
Received: from smtp.networkusa.net ([216.15.144.12]:45592 "EHLO
        smtp.networkusa.net") by vger.kernel.org with ESMTP
        id <S129516AbQKZUGQ>; Sun, 26 Nov 2000 15:06:16 -0500
Date: Sun, 26 Nov 2000 13:36:13 -0600
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
Message-ID: <20001126133612.B7698@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011251805340.8818-100000@duckman.distro.conectiva> <87ofz2lpdm.fsf@tigram.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <87ofz2lpdm.fsf@tigram.bogus.local>; from olaf.dietsche@gmx.net on Sun, Nov 26, 2000 at 04:33:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 04:33:25PM +0100, Olaf Dietsche wrote:
> A simple `gcc -march=i686' or `gcc -mpentiumpro' does fix it as
> well. So, if you configure your kernel with `CONFIG_M686=y' the problem
> should be gone.

Btw, was this ever tested on other arch's?  I don't remember seeing
anything come across this list.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
