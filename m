Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315708AbSETC2v>; Sun, 19 May 2002 22:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSETC2u>; Sun, 19 May 2002 22:28:50 -0400
Received: from panda.sul.com.br ([200.219.150.4]:61201 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S315708AbSETC2u>;
	Sun, 19 May 2002 22:28:50 -0400
Date: Sun, 19 May 2002 14:28:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020519172818.GF6129@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> <20020519124818.GA5481@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 19, 2002 at 09:48:18AM -0300, Arnaldo C. Melo escreveu:
> Em Sun, May 19, 2002 at 02:18:53PM +1000, Rusty Russell escreveu:
> > Some cases are endemic: whole subsystems or drivers where the author
> > obviously thought copy_from_user follows the kernel conventions:

Heads up: I'm fixing now the drivers/char ones...

- Arnaldo
