Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUAOXNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUAOXNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:13:38 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:16659 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264339AbUAOXNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:13:05 -0500
Date: Thu, 15 Jan 2004 21:23:47 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       sim@netnation.com
Subject: Re: Linux 2.4.25-pre5
Message-ID: <20040115232347.GF26401@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, sim@netnation.com
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet> <20040115145519.79beddc3.davem@redhat.com> <20040115231237.GE26401@conectiva.com.br> <20040115150137.253b47a2.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115150137.253b47a2.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 15, 2004 at 03:01:37PM -0800, David S. Miller escreveu:
> On Thu, 15 Jan 2004 21:12:37 -0200
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> 
> > Dave, haven't checked, but perhaps this cures it:
> > 
> > <marcelo:logos.cnet>:
> >   o Cset exclude: rtjohnso@eecs.berkeley.edu|ChangeSet|20040109135735|05388
> >   o Fix microcode update compilation error
> >   o Fix Makefile typo
> >  ^^^^^^^^^^^^^^^^^^^^
> >  ^^^^^^^^^^^^^^^^^^^^
> >  ^^^^^^^^^^^^^^^^^^^^
> 
> Don't think so, current bk://linux.bkbits.net/linux-2.4 that I can see
> still has "UBLEVEL" at the beginning of line 3 of linux/Makefile

oops, Marcelo?
