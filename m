Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTEFSMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 14:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTEFSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 14:12:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14780 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263918AbTEFSME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 14:12:04 -0400
Date: Tue, 6 May 2003 15:24:44 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Linux 2.5.69
Message-ID: <20030506182444.GC24780@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, Roger Luethi <rl@hellgate.ch>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <Pine.LNX.4.44.0305041739020.1737-100000@home.transmeta.com> <20030506133938.GA11062@k3.hellgate.ch> <1052230132.983.48.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052230132.983.48.camel@rth.ninka.net>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 06, 2003 at 07:08:52AM -0700, David S. Miller escreveu:
> On Tue, 2003-05-06 at 06:39, Roger Luethi wrote:
> > I'm seeing "kernel BUG at include/linux/module.h:284!" with 2.5.69.
> > 
> > I first suspected the early summer in Europe made my hardware flaky, but I
> > can't reproduce with 2.5.68.
> 
> Arnaldo, it's the socket module stuff.  He's using AF_UNIX
> as a module.

I'm reading this thread now, will study this.
