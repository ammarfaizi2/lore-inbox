Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWC1Ua0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWC1Ua0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWC1Ua0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:30:26 -0500
Received: from web37705.mail.mud.yahoo.com ([209.191.87.103]:32626 "HELO
	web37705.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932154AbWC1Ua0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:30:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WS/9XeOAehx3HJwgZgcc31Sq9h9xULazwwx400VXioGVAdJxV+y41ki6Yftlth7NCebzMF9+4uVe/zulcTR7y6+tcZ9xYoYzBIvicHzAYBjnhdsc9Py+PqVHBty68t6sRpVtRNL7mGBBeytU61WxKpOf7tNEuggbpXgBnorl5L4=  ;
Message-ID: <20060328203023.59855.qmail@web37705.mail.mud.yahoo.com>
Date: Tue, 28 Mar 2006 12:30:23 -0800 (PST)
From: Edward Chernenko <edwardspec@yahoo.com>
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
In-Reply-To: <1143561207.8009.58.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no>
wrote:
> > 
> > If so, then why khttpd _was_ included into kernel?
> 
> That has been widely acknowledged as a mistake.
> You'll note that khttpd
> was removed prior to the release of linux-2.6.0.
> Nobody misses it.
> 

That's bad. I think that some people need this, so my
module will be distributed like Tux webserver,
separately from kernel.

Anyway, can you help me by explaining your opinion
about my code, not about development phylosophy?
That's my first work and it's important to me to find
if I done something unefficient.

Edward Chernenko <edwardspec@gmail.com>


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
