Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRBXXx7>; Sat, 24 Feb 2001 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129726AbRBXXxk>; Sat, 24 Feb 2001 18:53:40 -0500
Received: from 2-225.cwb-adsl.telepar.net.br ([200.193.161.225]:44014 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129723AbRBXXxf>; Sat, 24 Feb 2001 18:53:35 -0500
Date: Sat, 24 Feb 2001 19:14:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Frédéric L. W. Meunier <0@pervalidus.net@conectiva.com.br,
        @pop.zip.com.au>@conectiva.com.br
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why CONFIG_MPENTIUMIII by default?
Message-ID: <20010224191407.B2564@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Frédéric L. W. Meunier <0@perv
	alidus.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010224204253.F127@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010224204253.F127@pervalidus>; from 0@pervalidus.net on Sat, Feb 24, 2001 at 08:42:53PM -0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 24, 2001 at 08:42:53PM -0300, Frédéric L. W. Meunier escreveu:
> Is there any reason to use CONFIG_MPENTIUMIII by default? I
> think this should be changed to CONFIG_M386, which should work
> for most, and would avoid people reporting problems because
> they forgot to set the right processor type.

humm AFAIK the default config is nothing more than Linus setup, not
something to server as a basic setup for everybody, so go buy Linus a i386
machine for development 8)

- Arnaldo
