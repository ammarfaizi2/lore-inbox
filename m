Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136133AbRASBAq>; Thu, 18 Jan 2001 20:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136503AbRASBAh>; Thu, 18 Jan 2001 20:00:37 -0500
Received: from phoenix.nanospace.com ([209.213.199.19]:52490 "HELO
	phoenix.nanospace.com") by vger.kernel.org with SMTP
	id <S136133AbRASBA0>; Thu, 18 Jan 2001 20:00:26 -0500
Date: Thu, 18 Jan 2001 17:00:23 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
Message-ID: <20010118170023.A3694@thune.yy.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3A66D93C.8090500@AnteFacto.com> <Pine.LNX.4.21.0101182150060.27730-100000@server.serve.me.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <Pine.LNX.4.21.0101182150060.27730-100000@server.serve.me.nl>; from maillist@chello.nl on Thu, Jan 18, 2001 at 09:52:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 09:52:02PM +0100, Igmar Palsenberg wrote:
> I use lstat to check if a config file is a symlink, and if it is, it
> refuses to open it. 

Nice race condition.

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
