Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311547AbSCNGm1>; Thu, 14 Mar 2002 01:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311529AbSCNGmQ>; Thu, 14 Mar 2002 01:42:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:48139 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311527AbSCNGmI>; Thu, 14 Mar 2002 01:42:08 -0500
Date: Thu, 14 Mar 2002 02:36:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ben Greear <greearb@candelatech.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
In-Reply-To: <3C904437.7080603@candelatech.com>
Message-ID: <Pine.LNX.4.21.0203140235010.4803-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002, Ben Greear wrote:

> Can you plz tell me (us) what the bk clone command is?
> 
> I tried:
> 
>   bk clone bk://linux24.bkbits.net//linux-2.4
> 
> and
> 
>   bk clone bk://linux24.bkbits.net///linux-2.4
> 
> But it does not work.

[marcelo@plucky tmp]$ bk clone bk://linux24.bkbits.net/linux-2.4/
SCCS/s.COPYING
...

Works just fine here.



