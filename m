Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSI0HWs>; Fri, 27 Sep 2002 03:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261648AbSI0HWs>; Fri, 27 Sep 2002 03:22:48 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:23820 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261451AbSI0HWr>; Fri, 27 Sep 2002 03:22:47 -0400
Date: Fri, 27 Sep 2002 04:27:54 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Message-ID: <20020927072754.GA23807@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <924963807@toto.iv> <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2002 at 01:56:28PM +1000, Peter Chubb escreveu:
> (like the generic hashing code linux/ghash.h which has been in the
> kernel for 4 or 5 years, and still has *no* uses.)

Hey, submit a patch removing this stuff then. If not I'll bite the bullet check
it and do it myself :-)

- Arnaldo
