Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278303AbRJMOZg>; Sat, 13 Oct 2001 10:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278304AbRJMOZ0>; Sat, 13 Oct 2001 10:25:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:41746 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278303AbRJMOZM>;
	Sat, 13 Oct 2001 10:25:12 -0400
Date: Sat, 13 Oct 2001 11:25:52 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Abhishek Rai <abbashake007@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question : spinlock
Message-ID: <20011013112552.A11166@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Abhishek Rai <abbashake007@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011013141804.51667.qmail@web11406.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011013141804.51667.qmail@web11406.mail.yahoo.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 13, 2001 at 07:18:04AM -0700, Abhishek Rai escreveu:
> > Can anybody tell me/ direct me to some tutorial/web
> > site/manual etc/ where i can gather the concepts of
> > Spin locks in linux, and get a good idea of the
> > commonly used functions like : spin_lock_irqsave()
> > etc.
> > abhishek
 
> PS : since i am not registered with the list please
> make sure that u peronally send me the reply at
> abbashake007@yahoo.com

sheesh, calm down, the answer is coming 8)

The very reliable Rusty's "Unreliable Guide To Locking":
http://kernelnewbies.org/documents/kdoc/kernel-locking/lklockingguide.html

also available at your local hard disk, at
/wherever_you_put_your_linux_sources/Documentation/DocBook

try:

make htmldocs

8)

- Arnaldo

``"90% of everything is crap", Its called Sturgeon's law 8)
One of the problems is indeed finding the good bits''
    - Alan Cox

