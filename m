Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTHYSQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTHYSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:16:21 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:62980 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262049AbTHYSQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:16:15 -0400
Date: Mon, 25 Aug 2003 15:24:42 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Fox Chen <mhchen@golf.ccl.itri.org.tw>,
       Gustavo Niemeyer <niemeyer@conectiva.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1: wl3501_cs.c doesn't compile
Message-ID: <20030825182441.GF1094@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Fox Chen <mhchen@golf.ccl.itri.org.tw>,
	Gustavo Niemeyer <niemeyer@conectiva.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	linux-net@vger.kernel.org
References: <20030824171318.4acf1182.akpm@osdl.org> <20030825173007.GT7038@fs.tum.de> <20030825174627.GA1094@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825174627.GA1094@conectiva.com.br>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 25, 2003 at 02:46:27PM -0300, Arnaldo C. Melo escreveu:
> Em Mon, Aug 25, 2003 at 07:30:07PM +0200, Adrian Bunk escreveu:
> > I got the following compile error in 2.6.0-test4-mm1:
> 
> I'm checking this now...

Problem doesn't exists in 2.6.0-test4 vanilla (ok, it has patch-2.6.0-test4-pa2
the latest parisc patchset, but it doesn't touches what we're looking at here),
now to test 2.6.0-test4-mm1...

Ah, compiling it as a module.

- Arnaldo
