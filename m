Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTFAGZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 02:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTFAGZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 02:25:44 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:24595 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261322AbTFAGZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 02:25:41 -0400
Date: Sun, 1 Jun 2003 03:39:47 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030601063946.GF10719@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054446976.19557.23.camel@spc>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole escreveu:
> Greetings all,
> 
> I've been converting the few files with old-style function prototypes to
> ANSI C, and I would like to make sure the following is acceptable. 
> 
> Original form:
> 
> int
> foo()
> {
>    	/* body here */
> }	
> 
> Proposed conversion:
> 
> int foo(void)
> {
>    	/* body here */
> }	
> 
> The above should be straightforward, but if there are any problems with
> that, please holler.  I'll be sending patches through the maintainers
> soon.

Perfect!

- Arnaldo
