Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315251AbSDWQGf>; Tue, 23 Apr 2002 12:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315256AbSDWQGe>; Tue, 23 Apr 2002 12:06:34 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14345 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315251AbSDWQGd>; Tue, 23 Apr 2002 12:06:33 -0400
Date: Tue, 23 Apr 2002 17:06:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>, Jes Sorensen <jes@wildopensource.com>,
        Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020423170606.A2202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org> <20020421105437.L10525@work.bitmover.com> <m3elh6obt7.fsf@trained-monkey.org> <20020423080216.E25771@work.bitmover.com> <m38z7eo3m7.fsf@trained-monkey.org> <20020423081239.F25771@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 08:12:39AM -0700, Larry McVoy wrote:
> If you're willing to use BK just as a transport, it's a far more efficient
> transport.  Ask people who have run rsync/ftp/bk all on the same system,
> the BK way gets the same information across in less bits.

If it gets the information across.  So far I haven't found any feature
in BK to allow restarting a pull or clone once it is interrupted.
For that reason I use rsync to get a large BK repo to my home machines,
which often is temporarily disconnected from the ISP.

