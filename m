Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRCPPll>; Fri, 16 Mar 2001 10:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRCPPlb>; Fri, 16 Mar 2001 10:41:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:21512 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130531AbRCPPlQ>; Fri, 16 Mar 2001 10:41:16 -0500
Date: Fri, 16 Mar 2001 02:04:23 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Delfim Machado <bipbip@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp or die ??!?!
Message-ID: <20010316020423.E1011@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Delfim Machado <bipbip@bigfoot.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AB21A81.3080401@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3AB21A81.3080401@bigfoot.com>; from bipbip@bigfoot.com on Fri, Mar 16, 2001 at 01:52:01PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 16, 2001 at 01:52:01PM +0000, Delfim Machado escreveu:
> hi,
> 
> i'm trying to compile my single cpu without the smp and it gives me a 
> long compile errors ...
> 
> with the smp enable, i can compile all the kernel without any problems

make mrproper

?

- Arnaldo
