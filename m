Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313705AbSDHRMa>; Mon, 8 Apr 2002 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313706AbSDHRM3>; Mon, 8 Apr 2002 13:12:29 -0400
Received: from dns.vamo.orbitel.bg ([195.24.63.30]:1664 "EHLO
	idi.vamo.orbitel.bg") by vger.kernel.org with ESMTP
	id <S313705AbSDHRM3>; Mon, 8 Apr 2002 13:12:29 -0400
Message-ID: <3CB1CF4D.794AAFFE@vamo.orbitel.bg>
Date: Mon, 08 Apr 2002 20:11:42 +0300
From: Ivan Ivanov <ivandi@vamo.orbitel.bg>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2 quota bug in 2.4.18
In-Reply-To: <3CA8A379.EA510E15@vamo.orbitel.bg> <20020408144431.GB23734@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

> > on ext2 filesystem chown/chgroup doesn't change quota
> > ext3 is OK
>   Kernel version, quota utils version, etc...?
>
>                                                 Honza

kernel 2.4.18
quota 2.00 and 3.04

also
kernel 2.4.18 with 50_quota-patch-2.4.15-2.4.16 + dquot_deadlock.diff

ext3 works fine

-----
Ivan



