Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbSJGXmF>; Mon, 7 Oct 2002 19:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbSJGXmE>; Mon, 7 Oct 2002 19:42:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54985 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262628AbSJGXmE>; Mon, 7 Oct 2002 19:42:04 -0400
Date: Mon, 7 Oct 2002 20:47:33 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Porter <porter@cox.net>, "David S. Miller" <davem@redhat.com>,
       giduru@yahoo.com, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
Message-ID: <20021007234733.GN3485@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Porter <porter@cox.net>,
	"David S. Miller" <davem@redhat.com>, giduru@yahoo.com,
	Andre Hedrick <andre@linux-ide.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org> <20021005205238.47023.qmail@web13201.mail.yahoo.com> <20021005.212832.102579077.davem@redhat.com> <20021007092212.B18610@home.com> <20021007230109.GI3485@conectiva.com.br> <1034033007.26504.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034033007.26504.44.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 08, 2002 at 12:23:27AM +0100, Alan Cox escreveu:
> On Tue, 2002-10-08 at 00:01, Arnaldo Carvalho de Melo wrote:
> to tweak
> > > the values exactly how we want in a specific application.  The tweaking
> > > options can be buried under advanced kernel options with the appropriate
> > > disclaimers about shooting yourself in the foot.
> >  
> > That is how I think it should be done, yes.
> 
> Submitting dprintk() seems like a great starting point. I've also got
> some patches in the archive someone sent that allows you to configure
> out the #! exec stuff

Ok, will do that in the next days.

- Arnaldo (buried alive in cleanups)
