Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVAEEFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVAEEFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 23:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAEEFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 23:05:04 -0500
Received: from mail.joq.us ([67.65.12.105]:3753 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262240AbVAEEEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 23:04:52 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>
	<20050103140359.GA19976@infradead.org>
	<1104862614.8255.1.camel@krustophenia.net>
	<20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
	<1104865198.8346.8.camel@krustophenia.net>
	<1104878646.17166.63.camel@localhost.localdomain>
	<20050104175043.H469@build.pdx.osdl.net>
	<1104890131.18410.32.camel@krustophenia.net>
	<20050104180541.P2357@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 04 Jan 2005 22:06:07 -0600
In-Reply-To: <20050104180541.P2357@build.pdx.osdl.net> (Chris Wright's
 message of "Tue, 4 Jan 2005 18:05:43 -0800")
Message-ID: <87652cikpc.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> * Lee Revell (rlrevell@joe-job.com) wrote:
>> The last time I checked users could belong to more than one group.  Am I
>> missing something?
>
> No, you're not.  I think Alan's just saying the gid based checks
> are suboptimal if there's a cleaner way to do it (to which I agree).
> Personally, I don't have a big problem with the Realtime LSM.  I've helped
> you with it, and suggested a few times that I'd prefer it to be generic;
> but never stepped up to deliver code of that sort.  Since it's your itch,
> you've scratched it, and it's quite simple and contained, I consider
> it acceptable.

We appreciate the help, Chris.  The patch is considerably smaller and
cleaner thanks to your efforts.
-- 
  joq
