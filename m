Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTFHPTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTFHPTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:19:52 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:6674 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262032AbTFHPTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:19:51 -0400
Date: Sun, 8 Jun 2003 12:34:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] compile fixes for recent changes to include/net/sock.h
Message-ID: <20030608153447.GH11552@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, azarah@gentoo.org,
	linux-kernel@vger.kernel.org
References: <1055007025.6805.19.camel@nosferatu.lan> <20030607210338.GE10340@conectiva.com.br> <20030608.021129.115917085.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608.021129.115917085.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jun 08, 2003 at 02:11:29AM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sat, 7 Jun 2003 18:03:38 -0300
>    
>    Question: it is marked as OBSOLETE, should we ditch it now?
> 
> Unfortunately I have no idea how widely used ethertap is these
> days, and more importantly if most people have switched over
> to tun/tap for those kinds of applications.

I see, ok, it is already marked OBSOLETE, so we can ditch it in 2.8/3.0.

- Arnaldo
