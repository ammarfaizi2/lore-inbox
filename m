Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136415AbRA1Pri>; Sun, 28 Jan 2001 10:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136396AbRA1Pr3>; Sun, 28 Jan 2001 10:47:29 -0500
Received: from 4-035.cwb-adsl.brasiltelecom.net.br ([200.193.163.35]:63222
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S132290AbRA1PrU>; Sun, 28 Jan 2001 10:47:20 -0500
Date: Sun, 28 Jan 2001 12:03:12 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010128120312.E19833@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010127151141.E8236@conectiva.com.br> <20511.980695218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20511.980695218@redhat.com>; from dwmw2@infradead.org on Sun, Jan 28, 2001 at 03:20:18PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 28, 2001 at 03:20:18PM +0000, David Woodhouse escreveu:
> 
> acme@conectiva.com.br said:
> >  Please send additions and corrections to me and I'll try to keep it
> > updated.
> 
> Anything which uses sleep_on() has a 90% chance of being broken. Fix
> them all, because we want to remove sleep_on() and friends in 2.5.

TODO updated, availabe at http://bazar.conectiva.com.br/~acme/TODO

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
