Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281788AbRKQR6H>; Sat, 17 Nov 2001 12:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281793AbRKQR5s>; Sat, 17 Nov 2001 12:57:48 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:39686 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281789AbRKQR5p>;
	Sat, 17 Nov 2001 12:57:45 -0500
Date: Sat, 17 Nov 2001 15:57:35 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: partha@us.ibm.com (Partha Narayanan), linux-kernel@vger.kernel.org
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo Molnar
Message-ID: <20011117155735.A1966@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	partha@us.ibm.com (Partha Narayanan), linux-kernel@vger.kernel.org
In-Reply-To: <OF130223C2.EFFE9842-ON85256B07.0052CC33@raleigh.ibm.com> <E1659ld-0007pU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1659ld-0007pU-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 17, 2001 at 06:00:37PM +0000, Alan Cox escreveu:
> >      The UniProcessor throughput  was reduced by 40%.
> >      The 4-way throughput showed a very slight degradation of 1%.
> >      The 8-way throughput showed an improvemnet of 10%.
> 
> This is the 10 billion thread volcanomark stuff though I assume ? What
> happens in the real world ?

Hey, those who need 10 billion threads can afford a 8-way machine or even
bigger ;)

- Arnaldo

``"90% of everything is crap", Its called Sturgeon's law 8)
One of the problems is indeed finding the good bits''
    - Alan Cox
