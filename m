Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282330AbRKWTqG>; Fri, 23 Nov 2001 14:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282294AbRKWTpq>; Fri, 23 Nov 2001 14:45:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:26121 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282223AbRKWTpS> convert rfc822-to-8bit; Fri, 23 Nov 2001 14:45:18 -0500
Date: Fri, 23 Nov 2001 16:27:48 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE is still crap.. or something
In-Reply-To: <012101c17452$9ac11550$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.21.0111231627020.11090-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any previous kernel gave you good performance ? 

On Fri, 23 Nov 2001, Martin Eriksson wrote:

> Well, just wanted to tell you that 2.4.15 still slows down to a crawl when
> copying a 500MB file between two hard drives (running ext3). I have tried
> any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14 IDE
> patch (after fixing the rejects) but no go.
> 
> Even iptables is affected, because it takes forever to surf the internet
> from my behind-linux-firewall windows computer.
> 
> I'm right now trying to apply the preemptive-kernel patch to 2.4.15 but it
> had some strange rejects so it will be exciting to see if it works. I get
> good response from the -ac kernel series though.
> 
> _____________________________________________________
> |  Martin Eriksson <nitrax@giron.wox.org>
> |  MSc CSE student, department of Computing Science
> |  Umeå University, Sweden
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

