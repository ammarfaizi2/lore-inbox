Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSLQOyy>; Tue, 17 Dec 2002 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSLQOyy>; Tue, 17 Dec 2002 09:54:54 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:34433 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S265114AbSLQOyx>;
	Tue, 17 Dec 2002 09:54:53 -0500
Date: Tue, 17 Dec 2002 16:02:35 +0100
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       joe user <joe_user35@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: netstat and 2.5.5[12]
Message-ID: <20021217150235.GA1116@gagarin>
References: <F108c41W2ufyWOxbCJn0000a14c@hotmail.com> <20021216124553.GA3727@gagarin> <20021217145931.GA1536@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021217145931.GA1536@conectiva.com.br>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18OJEx-00014y-00*03SF0bkwnIc* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:59:31PM -0200, Arnaldo Carvalho de Melo wrote:
> > Happens here too.
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103974450111945&w=2
> > 
> > A cat /proc/net/tcp causes the same problem, so not tools problem.
> 
> I'm looking into this, do you have ipv6 connections?

Yes, and I have daemons listening on ipv6.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
