Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRAaVd4>; Wed, 31 Jan 2001 16:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbRAaVdq>; Wed, 31 Jan 2001 16:33:46 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:17196 "EHLO
	tsmtp1.mail.isp") by vger.kernel.org with ESMTP id <S129093AbRAaVdb>;
	Wed, 31 Jan 2001 16:33:31 -0500
Message-ID: <3A788497.20501@terra.es>
Date: Wed, 31 Jan 2001 22:33:11 +0100
From: Miguel Rodríguez Pérez <migrax@terra.es>
Reply-To: migras@atlas.uvigo.es
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i586; en-US; m18) Gecko/20001103
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Adam Sampson <azz@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crash using DRI with 2.4.0 and 2.4.1
In-Reply-To: <3A7733F6.4070505@terra.es> <87n1c832nz.fsf@cartman.azz.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sampson wrote

> Are you sure you get the same results with 2.4.1? 

Yes, I'm sure. In fact I just downloaded the 2.4.1 kernel to test if 
this was fixed.

> I'm in the exact
> same position (G200 on a Gigabyte GA5AX with ALi M1541/3). There was a
> patch to properly support AGP on these boards which went in between
> 2.4.0 and 2.4.1 which solved the problem for me (at least in 2.4.0; I
> haven't tested DRI throughly in 2.4.1 yet).
> 

Can you send me that patch so I can test it.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
