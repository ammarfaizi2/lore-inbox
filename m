Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBGMT1>; Wed, 7 Feb 2001 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbRBGMTR>; Wed, 7 Feb 2001 07:19:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:65221 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129436AbRBGMTE>;
	Wed, 7 Feb 2001 07:19:04 -0500
Date: Wed, 7 Feb 2001 12:16:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207121604.A7254@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10102061741050.2193-100000@penguin.transmeta.com> <22688.981537032@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <22688.981537032@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, Feb 07, 2001 at 09:10:32AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 07, 2001 at 09:10:32AM +0000, David Howells wrote:
> 
> I presume that correct_size will always be a power of 2...

Yes.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
