Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWDKAGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWDKAGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWDKAGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:06:54 -0400
Received: from virtua-cwbas128-199.ctb.virtua.com.br ([201.21.141.199]:25104
	"EHLO oops.ghostprotocols.net") by vger.kernel.org with ESMTP
	id S932241AbWDKAGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:06:54 -0400
Date: Mon, 10 Apr 2006 21:04:19 -0300
To: "David S. Miller" <davem@davemloft.net>
Cc: snakebyte@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] leak in net/dccp/ipv4.c
Message-ID: <20060411000419.GA28645@mandriva.com>
Mail-Followup-To: acme@mandriva.com,
	"David S. Miller" <davem@davemloft.net>, snakebyte@gmx.de,
	linux-kernel@vger.kernel.org
References: <1144706846.31667.1.camel@alice> <20060410.164316.93690683.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410.164316.93690683.davem@davemloft.net>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
From: acme@mandriva.com (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 10, 2006 at 04:43:16PM -0700, David S. Miller escreveu:
> From: Eric Sesterhenn <snakebyte@gmx.de>
> Date: Tue, 11 Apr 2006 00:07:26 +0200
> 
> > we dont free req if we cant parse the options.
> > This fixes coverity bug id #1046
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> 
> Looks good.
> 
> Applied, thanks Eric.

Thanks everybody.

- Arnaldo
