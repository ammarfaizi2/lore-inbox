Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSLISDq>; Mon, 9 Dec 2002 13:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSLISDp>; Mon, 9 Dec 2002 13:03:45 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:12561 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265885AbSLISDo>; Mon, 9 Dec 2002 13:03:44 -0500
Date: Mon, 9 Dec 2002 16:11:10 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Serge Kuznetsov <serge@wcom.ca>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipv4/route: convert /proc/net/rt_cache to seq_file
Message-ID: <20021209181110.GT17067@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Serge Kuznetsov <serge@wcom.ca>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021208030851.GB12907@conectiva.com.br> <03c201c29fac$e7737510$9c094d8e@wcom.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c201c29fac$e7737510$9c094d8e@wcom.ca>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 09, 2002 at 01:00:48PM -0500, Serge Kuznetsov escreveu:
> > bk://kernel.bkbits.net/acme/net-2.5
> > 
> > Now there is just this outstanding changeset.
> > 
> 
> BTW: Is /proc/net/arp has been fixed?

Yes, I have submitted some changesets fixing problems with /proc/net/arp
seq_file handling. Please let me know if you find any problems.

- Arnaldo
