Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbULOJt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbULOJt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbULOJt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:49:57 -0500
Received: from [213.146.154.40] ([213.146.154.40]:54946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262318AbULOJtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:49:55 -0500
Date: Wed, 15 Dec 2004 09:49:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Montavista Realtime compilation failures
Message-ID: <20041215094954.GA19147@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <41BFD327.3000408@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BFD327.3000408@comcast.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 01:01:11AM -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The MontaVista patches[1] I applied to 2.6.9 are not compiling on
> x86_64.  I'm also using a PaX pre-patch, which I don't believe is
> interfering; there were collisions with PaX in mm/, but none of those
> show here (they were all in .c files, not headers, so they cannot have
> an impact here).

I think you're much better off complaining to mvista.

