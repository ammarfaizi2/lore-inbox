Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289829AbSAPDDq>; Tue, 15 Jan 2002 22:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289836AbSAPDDh>; Tue, 15 Jan 2002 22:03:37 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:57874 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289829AbSAPDD0>; Tue, 15 Jan 2002 22:03:26 -0500
Date: Wed, 16 Jan 2002 14:03:35 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: dhowells@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: [PATCH] need_resched abstraction
Message-Id: <20020116140335.694c2bfa.rusty@rustcorp.com.au>
In-Reply-To: <3C43F692.AFB49A9E@mandrakesoft.com>
In-Reply-To: <23480.1011085988@warthog.cambridge.redhat.com>
	<3C43F692.AFB49A9E@mandrakesoft.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 04:29:54 -0500
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Call me picky but I like the name cond_resched()   ;-)

... And I prefer maybe_schedule().

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
