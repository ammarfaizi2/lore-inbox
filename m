Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJNOiM>; Mon, 14 Oct 2002 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSJNOiM>; Mon, 14 Oct 2002 10:38:12 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:55734 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261750AbSJNOiL>; Mon, 14 Oct 2002 10:38:11 -0400
Date: Mon, 14 Oct 2002 09:42:55 -0500
From: Shawn <core@enodev.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Michael Clark <michael@metaparadigm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014094255.B27417@q.mn.rr.com>
References: <3DA99CEC.8040208@metaparadigm.com> <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu>; from viro@math.psu.edu on Sun, Oct 13, 2002 at 01:10:49PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13, Alexander Viro said something like:
> 	Mostly those who won't have to clean up the mess afterwards.
> For the record, my vote is "not ready".

Oh shit! This is the "Al Viro stink test" Linus spoke of.

Now, if no LVM type ifrastructure is included in 2.6, all (all who use an
LVM of some type) will all have to

1. update to the latest mainline
2. download the latest dm or evms patch
3. fix all the patch rejects themselves (big problem to overcome when
trying to get people to test with the latest kernel)

I'm NOT saying this is some kind of argument toward inclusion. I guess
I'm just lamenting. I really hoped I'd have one less 3rd party patch to
maintain in my own personal tree.

--
Shawn Leas
core@enodev.com

I was in the first submarine.  Instead of a periscope, they had
a kaleidoscope.  "We're surrounded."
						-- Stephen Wright
