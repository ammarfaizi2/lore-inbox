Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSEUIMK>; Tue, 21 May 2002 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316034AbSEUIMJ>; Tue, 21 May 2002 04:12:09 -0400
Received: from imladris.infradead.org ([194.205.184.45]:25609 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314448AbSEUIMJ>; Tue, 21 May 2002 04:12:09 -0400
Date: Tue, 21 May 2002 09:12:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Larry McVoy <lm@work.bitmover.com>, Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] push down inclusion of buffer_head.h into users
Message-ID: <20020521091203.A6252@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020520190033.A414@infradead.org> <20020521011108.A22488@infradead.org> <20020520181731.K2996@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 06:17:31PM -0700, Larry McVoy wrote:
> Hi Christoph,
> 
> while it is true that BK will do the right thing if Linus applies this patch
> and then you pull it, it's a lot nicer if you let him pull your tree.  

Who sais that I actually have a checked in BK tree of it?  For all one-time
patches I just edit a checked out BK tree, crate an unified diff using
bk diffs -u and then clean all modified files using a small script.

