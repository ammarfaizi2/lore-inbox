Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTGDNNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 09:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbTGDNNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 09:13:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:26888 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266025AbTGDNNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 09:13:53 -0400
Date: Fri, 4 Jul 2003 14:28:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, akpm@digeo.com, akpm@osdl.org, jari.ruusu@pp.inet.fi,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030704142818.A31854@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com, akpm@osdl.org,
	jari.ruusu@pp.inet.fi, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <UTC200307041321.h64DLFm03639.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200307041321.h64DLFm03639.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Jul 04, 2003 at 03:21:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 03:21:15PM +0200, Andries.Brouwer@cwi.nl wrote:
> BTW - So far, Clemens and Jari and I have been cooperating and
> discussing every step. Most of your statements seem unfounded to me.

I'd be happy to take everything back :)  But so far I've only heard
him moaning that

  a) the cryptoloop implementation you submitted is the worst possible
     one (without any backing)
  b) the changes proposed by akpm and me would break external modules
     (which they would, but that's life and we've never cared much
     about outside drivers) und would make them slower which is
     utterly bogus.

But hey, let's give him time to defend himself..

