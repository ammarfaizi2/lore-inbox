Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143434AbRA1QSX>; Sun, 28 Jan 2001 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143436AbRA1QSN>; Sun, 28 Jan 2001 11:18:13 -0500
Received: from 4-035.cwb-adsl.brasiltelecom.net.br ([200.193.163.35]:62455
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S143434AbRA1QR6>; Sun, 28 Jan 2001 11:17:58 -0500
Date: Sun, 28 Jan 2001 12:33:52 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        lwn@lwn.net
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010128123352.J19833@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
	lwn@lwn.net
In-Reply-To: <20010127151141.E8236@conectiva.com.br> <3A74451F.DA29FD17@uow.edu.au> <20010128122850.I19833@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010128122850.I19833@conectiva.com.br>; from acme@conectiva.com.br on Sun, Jan 28, 2001 at 12:28:50PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 28, 2001 at 12:28:50PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 29, 2001 at 03:13:19AM +1100, Andrew Morton escreveu:
> > Arnaldo Carvalho de Melo wrote:
> > > 
> > > Please send additions and corrections to me and I'll try
> > > to keep it updated.
> > 
> > Here - have about 300 bugs:
> > 
> > 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> > 
> > A lot of the timer deletion races are hard to fix because of
> > the deadlock problem.
> 
> added, please keep sending, and as somebody pointed out: it is good to have
> explanations about what have to be done, so interested people can
> contribute, specially people that are looking to start helping and don't
> know where to start, now we can say "hey, pick one of these 300 bugs and
> start doing something!" ;)

I forgot to add: "Like Andrew did in the above URL" 8)

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
