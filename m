Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271371AbTGQKDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271374AbTGQKDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:03:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57613 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271371AbTGQKDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:03:42 -0400
Date: Thu, 17 Jul 2003 11:18:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@digeo.com>,
       Daniel Phillips <phillips@arcor.de>, acme@conectiva.com.br, cw@f00f.org,
       torvalds@transmeta.com, geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Message-ID: <20030717111805.A18449@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pavel Machek <pavel@suse.cz>, Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>, Daniel Phillips <phillips@arcor.de>,
	acme@conectiva.com.br, cw@f00f.org, torvalds@transmeta.com,
	geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk, perex@suse.cz,
	linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <20030622014345.GD10801@conectiva.com.br> <20030621191705.3c1dbb16.akpm@digeo.com> <200306221522.29653.phillips@arcor.de> <20030622103251.158691c3.akpm@digeo.com> <20030623010555.GA4302@work.bitmover.com> <20020104113205.GB1778@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020104113205.GB1778@zaurus.ucw.cz>; from pavel@suse.cz on Fri, Jan 04, 2002 at 12:32:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 12:32:05PM +0100, Pavel Machek wrote:
> Perhaps someone schould create 2.7.3 with long long bugs fixed
> and with c99 initializers?

2.7 does have C99 initializers.

