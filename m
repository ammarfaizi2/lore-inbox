Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSEUXdz>; Tue, 21 May 2002 19:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316787AbSEUXdY>; Tue, 21 May 2002 19:33:24 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:43493 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S316786AbSEUXdQ>; Tue, 21 May 2002 19:33:16 -0400
Date: Tue, 21 May 2002 16:33:14 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Wayne.Brown@altec.com
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <86256BC0.00807DCA.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.44.0205211629530.2666-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002 Wayne.Brown@altec.com wrote:

> 
> 
> Thanks for the information.
> 
> So, I'm just getting used to the idea of using new tools to build kernels, and
> now I learn that 2.5 breaks an ordinary program that I use all day, every day.
> It just keeps getting better and better...
> 

I don't recall how many time stuff that touched proc broke in the 
.99-1.3-2.0 era but it was a few...

the proc filesystem is not an snmp mib.
 
> 
> 
> 
> "David S. Miller" <davem@redhat.com> on 05/21/2002 04:30:11 PM
> 
> To:   Wayne Brown/Corporate/Altec@Altec
> cc:   linux-kernel@vger.kernel.org
> 
> Subject:  Re: Linux-2.5.17
> 
> 
> 
>    From: Wayne.Brown@altec.com
>    Date: Tue, 21 May 2002 13:52:08 -0500
> 
>    Under 2.5.17 there is a problem with gtop 1.0.9.
> 
> The /proc/meminfo output changed, and this makes a lot of programs
> reading that file explode.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


