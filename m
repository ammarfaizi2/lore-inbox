Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSLWBzz>; Sun, 22 Dec 2002 20:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265636AbSLWBzz>; Sun, 22 Dec 2002 20:55:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:42513 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265628AbSLWBzz>; Sun, 22 Dec 2002 20:55:55 -0500
Date: Mon, 23 Dec 2002 00:03:36 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       joe user <joe_user35@hotmail.com>
Subject: Re: [PATCH] /proc/net/tcp + ipv6 hang
Message-ID: <20021223020336.GN4942@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anders Gustafsson <andersg@0x63.nu>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	joe user <joe_user35@hotmail.com>
References: <20021223015723.GA17439@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223015723.GA17439@gagarin>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 23, 2002 at 02:57:23AM +0100, Anders Gustafsson escreveu:
> Hi,
> 
> this patch fixes an infinite loop when reading /proc/net/tcp and having
> daemons listening on ipv6.

I'm checking your patch, just received the message, but thanks a lot for 
doing this!

- Arnaldo
