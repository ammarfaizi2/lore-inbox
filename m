Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274718AbRIUAHp>; Thu, 20 Sep 2001 20:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274717AbRIUAHf>; Thu, 20 Sep 2001 20:07:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20753 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274715AbRIUAH0>;
	Thu, 20 Sep 2001 20:07:26 -0400
Date: Thu, 20 Sep 2001 21:07:39 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH][RFC] spin_trylock_bh
Message-ID: <20010920210739.C1450@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
	paulus@samba.org
In-Reply-To: <20010915172659.A1916@conectiva.com.br> <20010920.165953.102611286.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010920.165953.102611286.davem@redhat.com>; from davem@redhat.com on Thu, Sep 20, 2001 at 04:59:53PM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 20, 2001 at 04:59:53PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sat, 15 Sep 2001 17:26:59 -0300
> 
>    	Please see if this is acceptable, I noticed this while working on
>    the locks for NetBEUI 8) Patch is against 2.4.9, but it should apply to
>    latest prepatch. It was being used in the ppp code for quite some time.
>    
> This patch looks fine to me...

It is already in 2.4.9-ac12, hope it'll be merged with Linus soon.

- Arnaldo
