Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132678AbRC2E43>; Wed, 28 Mar 2001 23:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132679AbRC2E4T>; Wed, 28 Mar 2001 23:56:19 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:8293 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132678AbRC2E4Q>; Wed, 28 Mar 2001 23:56:16 -0500
Date: Wed, 28 Mar 2001 22:55:29 -0600 (CST)
From: Paul Cassella <pwc@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hangs under 2.4.2-ac{18,19,24} that do not happen under -ac12.
In-Reply-To: <E14iTlA-000747-00@the-village.bc.nu>
Message-ID: <Pine.SGI.3.96.1010328221323.12073A-100000@fsgi626.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001, Alan Cox wrote:

> Was anything between 12 and 18 stable ?

I didn't actually try them; I jumped right from 12 to 18, and when that
and 19 died, I went back to 12. 

But a quick look suggests that the entire patch I'd applied to 12 and got
a hang with was in 13, including the pm.c change.

I also haven't tried anything after 24; is it likely to have been fixed?

-- 
Paul Cassella

