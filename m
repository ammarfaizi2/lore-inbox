Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137077AbRA1QNM>; Sun, 28 Jan 2001 11:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143404AbRA1QNC>; Sun, 28 Jan 2001 11:13:02 -0500
Received: from 4-035.cwb-adsl.brasiltelecom.net.br ([200.193.163.35]:58871
	"HELO brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S137077AbRA1QM4>; Sun, 28 Jan 2001 11:12:56 -0500
Date: Sun, 28 Jan 2001 12:28:50 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010128122850.I19833@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
	lwn@lwn.net
In-Reply-To: <20010127151141.E8236@conectiva.com.br> <3A74451F.DA29FD17@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A74451F.DA29FD17@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jan 29, 2001 at 03:13:19AM +1100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 29, 2001 at 03:13:19AM +1100, Andrew Morton escreveu:
> Arnaldo Carvalho de Melo wrote:
> > 
> > Please send additions and corrections to me and I'll try
> > to keep it updated.
> 
> Here - have about 300 bugs:
> 
> 	http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> 
> A lot of the timer deletion races are hard to fix because of
> the deadlock problem.

added, please keep sending, and as somebody pointed out: it is good to have
explanations about what have to be done, so interested people can
contribute, specially people that are looking to start helping and don't
know where to start, now we can say "hey, pick one of these 300 bugs and
start doing something!" ;)

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
