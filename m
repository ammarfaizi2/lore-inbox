Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274131AbRISSRM>; Wed, 19 Sep 2001 14:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274133AbRISSQx>; Wed, 19 Sep 2001 14:16:53 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:48007 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S274130AbRISSQf>; Wed, 19 Sep 2001 14:16:35 -0400
Date: Wed, 19 Sep 2001 14:16:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010919141656.A5021@redhat.com>
In-Reply-To: <torvalds@transmeta.com> <5079.1000911203@warthog.cambridge.redhat.com> <20010919200357.Z720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010919200357.Z720@athlon.random>; from andrea@suse.de on Wed, Sep 19, 2001 at 08:03:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 08:03:57PM +0200, Andrea Arcangeli wrote:
> I inlined the patch below (may need some conversion to likely/unlikely
> as well).

I don't know about you, but I'm mildly concerned that copyright attributions 
vanished.

		-ben
