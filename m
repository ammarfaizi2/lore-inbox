Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbRAaRRL>; Wed, 31 Jan 2001 12:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132448AbRAaRQ7>; Wed, 31 Jan 2001 12:16:59 -0500
Received: from mailhost.terra.es ([195.235.113.151]:54101 "EHLO
	tsmtp4.mail.isp") by vger.kernel.org with ESMTP id <S132044AbRAaRQw>;
	Wed, 31 Jan 2001 12:16:52 -0500
Message-ID: <3A78486E.4080609@terra.es>
Date: Wed, 31 Jan 2001 18:16:30 +0100
From: Miguel Rodríguez Pérez <migrax@terra.es>
Reply-To: migras@atlas.uvigo.es
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1 i586; en-US; m18) Gecko/20010119
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

Adam Sampson wrote:

> Miguel Rodriguez Perez <migrax@terra.es> writes:
> 
>> Hi, I have a Matrox G200 card installed on an Ali motherboard.
>> Sometimes when I use any opengl program my box crashes. It is more
>> likely that it will crash if I have used the xvideo extension or the
>> matroxfb, but this is not a must, it simply increases the chance of
>> a crash, which is very high anyway.
> 
>> I have tried both 2.4.0 and 2.4.1 kernels with Xfree 4.0.2 both with
>> the same results.
> 
> 
> Are you sure you get the same results with 2.4.1? I'm in the exact
> same position (G200 on a Gigabyte GA5AX with ALi M1541/3). There was a
> patch to properly support AGP on these boards which went in between
> 2.4.0 and 2.4.1 which solved the problem for me (at least in 2.4.0; I
> haven't tested DRI throughly in 2.4.1 yet).

> 
I'm sure it crashes with kernel 2.4.1 (I'm using it right now). Anyway, 
where can I find that patch, so I can try with a patched 2.4.0?

Thank you.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
