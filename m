Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312473AbSCYRv0>; Mon, 25 Mar 2002 12:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSCYRvG>; Mon, 25 Mar 2002 12:51:06 -0500
Received: from [209.249.147.145] ([209.249.147.145]:57608 "EHLO
	addr-mx01.addr.com") by vger.kernel.org with ESMTP
	id <S312473AbSCYRuu>; Mon, 25 Mar 2002 12:50:50 -0500
Date: Mon, 25 Mar 2002 12:07:17 -0500
From: Daniel Gryniewicz <dang@fprintf.net>
To: Marc Wilson <msw@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-Id: <20020325120717.11be1ecd.dang@fprintf.net>
In-Reply-To: <20020325085053.GB1382@moonkingdom.net>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002 00:50:53 -0800
Marc Wilson <msw@cox.net> wrote:

> On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> > Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> > '8305'?  If it doesn't appear, I'll send off my patch.
> 
> Sorry to disappoint you:
> 
> $ sudo lspci -n | grep 8305
> 00:01.0 Class 0604: 1106:8305
> 
> It's an Abit KT7A-RAID, which is a KT133A.
> 
> Having said that, I've been seeing odd video artifacts in xawtv windows
> since the patch was expanded from merely clearing bit 7. :)
> 
> -- 
> Marc Wilson
> msw@cox.net
> http://members.cox.net/msw
> 
> 

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
(KT7-RAID, KT133)
00:01.0 Class 0604: 1106:8305

Daniel
--- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary

