Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280016AbRKRSoq>; Sun, 18 Nov 2001 13:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRKRSog>; Sun, 18 Nov 2001 13:44:36 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:3807 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S280028AbRKRSo2>; Sun, 18 Nov 2001 13:44:28 -0500
Date: Sun, 18 Nov 2001 10:44:55 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Paul <krushka@iprimus.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compact Flash and IDE interface
In-Reply-To: <01111818410900.02037@paul.home.com.au>
Message-ID: <Pine.LNX.4.33.0111181039410.11341-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2MB a second is about right... Flash is slow... I get about that on an 
older 64MB simple technologies flash card... maybe their doc says 16Mb/s 
which would be quite accurate...


On Sun, 18 Nov 2001, Paul wrote:

> Hi
> 
> I hope I'm sending this to the right list, sorry if it's not :)
> 
> With compact flash cards connected via IDE what is the "normal" expected 
> transfer rates?  I have a Sandisk (32 and 128MB) and I only get around 
> 2MB/sec (read test using hdparm) when all the docs from sandisk suggest 
> around 16MB/sec.  They haven't returned my emails so I suspect their specs 
> are a little misleading...they quote around 16MB/sec read transfer rates.
> 
> What sort of read rates should I be expecting?
> 
> Thanks
> 
> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli				       joelja@darkwing.uoregon.edu    
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


