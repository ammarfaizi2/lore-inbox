Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290849AbSBFWZg>; Wed, 6 Feb 2002 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290851AbSBFWZR>; Wed, 6 Feb 2002 17:25:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38649
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290850AbSBFWZO>; Wed, 6 Feb 2002 17:25:14 -0500
Date: Wed, 6 Feb 2002 14:25:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Christoph Hellwig <hch@ns.caldera.de>,
        Larry McVoy <lm@bitmover.com>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206222506.GA327@mis-mike-wstn>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Larry McVoy <lm@bitmover.com>
In-Reply-To: <20020206000343.I14622@work.bitmover.com> <200202061935.g16JZLh18377@ns.caldera.de> <20020206123527.R7674@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020206123527.R7674@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to add my little nit.  This sounds better to me:

On Wed, Feb 06, 2002 at 12:35:27PM -0800, Larry McVoy wrote:
> ### Change the comments to ChangeSet below
> These are the changeset comments, i.e, the email message for the patch.
> 

### Comments for change to ChangeSet below

> ### Change the comments to include/asm/whatever.h below
> The comments for include/asm/whatever.h
> 
> In other words
> 
> printf("### Change the comments to %s below\n", filename);

printf("### Comments for change to %s below\n", filename);

Mike
