Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTGGCmr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 22:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbTGGCmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 22:42:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:61711 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264569AbTGGCmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 22:42:46 -0400
Date: Sun, 6 Jul 2003 23:57:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops with .74 snapshot.
Message-ID: <20030707025729.GG1820@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <87n0frp4v1.fsf@enki.rimspace.net> <1057540770.215922@palladium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057540770.215922@palladium.transmeta.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 06, 2003 at 06:19:29PM -0700, Linus Torvalds escreveu:
> Daniel Pittman wrote:
> >
> > I got the following series of oops reports when booting a .74 snapshot.
> > Following is information on the latest changeset in the CVS export
> > server, and the reports.
> 
> Just out of interest, does this fix it for you? It looks sane, but since
> David is off for the weekend, I don't want to apply it without some serious
> feedback that "yes, it fixes the problem".

Yes, that was what Yoshfuji fixed (he introduced the bug) :-)

- Arnaldo
