Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbSJGW5f>; Mon, 7 Oct 2002 18:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbSJGW4d>; Mon, 7 Oct 2002 18:56:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13250 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S263413AbSJGWzi>; Mon, 7 Oct 2002 18:55:38 -0400
Date: Mon, 7 Oct 2002 20:01:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Matt Porter <porter@cox.net>
Cc: "David S. Miller" <davem@redhat.com>, giduru@yahoo.com,
       andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007230109.GI3485@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
	giduru@yahoo.com, andre@linux-ide.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005205238.47023.qmail@web13201.mail.yahoo.com> <20021005.212832.102579077.davem@redhat.com> <20021007092212.B18610@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007092212.B18610@home.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 07, 2002 at 09:22:12AM -0700, Matt Porter escreveu:

> The ideal situation is if as we work on all these areas where we can reduce
> size, we provide fine grained options to tweak them (with a default
> desktop/server value and a default "tiny" value).  You can have this
> CONFIG_TINY or whatever, but then we should also provide the ability to tweak
> the values exactly how we want in a specific application.  The tweaking
> options can be buried under advanced kernel options with the appropriate
> disclaimers about shooting yourself in the foot.
 
That is how I think it should be done, yes.

- Arnaldo
