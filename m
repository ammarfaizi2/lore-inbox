Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281169AbRKKXjU>; Sun, 11 Nov 2001 18:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281168AbRKKXjL>; Sun, 11 Nov 2001 18:39:11 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:18703 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281169AbRKKXjE>;
	Sun, 11 Nov 2001 18:39:04 -0500
Date: Sun, 11 Nov 2001 21:38:49 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Franc@conectiva.com.br, ois Cami <stilgar2k@wanadoo.fr>
Cc: abusch@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: [oops] 2.4.14 ipchains/netfilter or scsi/usb ? modprobe on boot
Message-ID: <20011111213849.B999@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Franc@conectiva.com.br, ois Cami <stilgar2k@wanadoo.fr>,
	abusch@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <3BEF0419.BCD63716@gmx.net> <3BEF0BE7.3010603@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEF0BE7.3010603@wanadoo.fr>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 12, 2001 at 12:38:15AM +0100, Franc,ois Cami escreveu:
> Andreas Busch wrote:
> > When the system is up I also get an unresolved symbol "deactivate_page"
> > for loading the
> > "loop" device driver.  
> 
> _known_ bug
> patch is in 2.4.14pre1/pre2/pre3
> warning, 2.4.14pre1/pre2 do not work with iptables, whereas pre3 does.

humm, you mean 2.4.15pre, isn't it?

- Arnaldo
