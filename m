Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275603AbRI0FJ4>; Thu, 27 Sep 2001 01:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275277AbRI0FJq>; Thu, 27 Sep 2001 01:09:46 -0400
Received: from web10403.mail.yahoo.com ([216.136.130.95]:28934 "HELO
	web10403.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275603AbRI0FJh>; Thu, 27 Sep 2001 01:09:37 -0400
Message-ID: <20010927051000.12512.qmail@web10403.mail.yahoo.com>
Date: Thu, 27 Sep 2001 15:10:00 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: linux kernel 2.4.10 possibly breaks LILO
To: Ken Zalewski <kennyz@nycap.rr.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BB2A19D.1FB6D91A@nycap.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Ken Zalewski <kennyz@nycap.rr.com> wrote: >
Summary:
> 
> Modifying /etc/lilo.conf and running "lilo" when
> using kernel version
> 2.4.10 does not appear to modify the boot sector
.tux.org/lkml/ 

Negative here, I just modify lilo.conf, add the option
prompt; run lilo and reboot. It works fine.

I use 2.4.10 with preemt patch...

I believe the others options will work too.



=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
