Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTFHPqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTFHPqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:46:07 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:14354 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262015AbTFHPqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:46:02 -0400
Date: Sun, 8 Jun 2003 13:00:55 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.70-mm6: ethertap.c doesn't compile
Message-ID: <20030608160055.GI11552@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
	linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20030607151440.6982d8c6.akpm@digeo.com> <20030608155623.GG16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608155623.GG16164@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch, but it was already submitted by Martin@gentoo and I
pushed to Linus that already has this in his tree.

- Arnaldo

Em Sun, Jun 08, 2003 at 05:56:23PM +0200, Adrian Bunk escreveu:
> 
> I got the following compile error in 2.5.70-mm6:
> 
> <--  snip  -->
> 
