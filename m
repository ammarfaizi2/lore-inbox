Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTLZFHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 00:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264487AbTLZFHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 00:07:11 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:19206 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264485AbTLZFHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 00:07:09 -0500
Date: Fri, 26 Dec 2003 03:17:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22: Sending data using raw IP. HELP!!
Message-ID: <20031226051745.GI14954@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>,
	linux-kernel@vger.kernel.org
References: <3FEB9C70.9060504@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEB9C70.9060504@tait.co.nz>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 26, 2003 at 03:26:56PM +1300, Dmytro Bablinyuk escreveu:
> I need to send a data out using raw IP.
> For start I tried to send an ICMP response using the code below, but it 
> gives me a error (kernel 2.4.22) and clears the skb buffer without 
> sending it.

Could you please send this message to the linux-net@vger.kernel.org mailing
list? That is the proper place for these kinds of questions.

Thanks,

- Arnaldo
