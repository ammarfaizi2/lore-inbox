Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268091AbTAJBJg>; Thu, 9 Jan 2003 20:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268093AbTAJBJg>; Thu, 9 Jan 2003 20:09:36 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:40420 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S268091AbTAJBJf>; Thu, 9 Jan 2003 20:09:35 -0500
Date: Fri, 10 Jan 2003 14:17:52 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Wichert Akkerman <wichert@wiggy.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <1291230000.1042161472@localhost.localdomain>
In-Reply-To: <20030109155214.GX22951@wiggy.net>
References: <20030108130850.GQ22951@wiggy.net>
 <20030109123857.A15625@bitwizard.nl> <20030109155214.GX22951@wiggy.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, January 09, 2003 16:52:14 +0100 Wichert Akkerman 
<wichert@wiggy.net> wrote:

> Previously Rogier Wolff wrote:
>> Can you check the stats counters, to see if they are indeed dropped?
>
> It seems no packets are dropped:
>

...

> Tcp:
>     666 active connections openings
>     0 passive connection openings
>     0 failed connection attempts
>     0 connection resets received
>     2 connections established
>     58949 segments received
>     65043 segments send out
>     0 segments retransmited
>     18 bad segments received.

Is this it?  My counters show zero, in vastly more packets.

Andrew
