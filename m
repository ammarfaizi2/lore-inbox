Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbTDCB3D>; Wed, 2 Apr 2003 20:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbTDCB3C>; Wed, 2 Apr 2003 20:29:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10042 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263207AbTDCB3C>; Wed, 2 Apr 2003 20:29:02 -0500
Date: Wed, 2 Apr 2003 20:40:26 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, James Simmons <jsimmons@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why moving driver includes ?
Message-ID: <20030402204026.A15082@devserv.devel.redhat.com>
References: <mailman.1049324411.25620.linux-kernel2news@redhat.com> <200304030045.h330jok10685@devserv.devel.redhat.com> <3E8B8F31.5030407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E8B8F31.5030407@redhat.com>; from drepper@redhat.com on Wed, Apr 02, 2003 at 05:32:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 02 Apr 2003 17:32:33 -0800
> From: Ulrich Drepper <drepper@redhat.com>

> > Yeah, but what does it have to do with kernel? You should have
> > gotten Uli to add them to glibc.
> 
> Headers like have no place in glibc either.  There should be one or more
> separate packages which distribute kernel headers.

I can see your point, but imagine how many packages this is
going to create. Shall we plead with Arjan to maintain
glibc-kernelheaders as a community package, to be a clearinghouse
for these things?

-- Pete
