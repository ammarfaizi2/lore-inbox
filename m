Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbSLQOvp>; Tue, 17 Dec 2002 09:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSLQOvp>; Tue, 17 Dec 2002 09:51:45 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:15635 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265095AbSLQOvp>; Tue, 17 Dec 2002 09:51:45 -0500
Date: Tue, 17 Dec 2002 12:59:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: joe user <joe_user35@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: netstat and 2.5.5[12]
Message-ID: <20021217145931.GA1536@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anders Gustafsson <andersg@0x63.nu>,
	joe user <joe_user35@hotmail.com>, linux-kernel@vger.kernel.org
References: <F108c41W2ufyWOxbCJn0000a14c@hotmail.com> <20021216124553.GA3727@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216124553.GA3727@gagarin>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 16, 2002 at 01:45:53PM +0100, Anders Gustafsson escreveu:
> On Mon, Dec 16, 2002 at 01:06:32PM +0100, joe user wrote:
> > Is required a new net-tools package required to run 2.5.5[12]? If you run 
> > netstat -t the process just hang forever, and is unkillable.
> 
> Happens here too.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103974450111945&w=2
> 
> A cat /proc/net/tcp causes the same problem, so not tools problem.

I'm looking into this, do you have ipv6 connections?

- Arnaldo
