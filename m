Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbSLPR0j>; Mon, 16 Dec 2002 12:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbSLPR0i>; Mon, 16 Dec 2002 12:26:38 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:15365 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266971AbSLPR0h>; Mon, 16 Dec 2002 12:26:37 -0500
Date: Mon, 16 Dec 2002 17:34:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Collins <bcollins@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216173430.A7048@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Collins <bcollins@debian.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
References: <20021216171218.GV504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216171218.GV504@hopper.phunnypharm.org>; from bcollins@debian.org on Mon, Dec 16, 2002 at 12:12:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:12:18PM -0500, Ben Collins wrote:
> Linus, is there anyway I can request a hook so that anything that
> changes drivers/ieee1394/ in your repo sends me an email with the diff
> for just the files in that directory, and the changeset log? Is this
> something that bkbits can do?

How about subscribing to the commits list throw away every mail not
containing ieee1394 with procmail (or $MAILFILTER)?

