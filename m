Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281923AbRKUQvk>; Wed, 21 Nov 2001 11:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281904AbRKUQvb>; Wed, 21 Nov 2001 11:51:31 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:54450 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281922AbRKUQv1>;
	Wed, 21 Nov 2001 11:51:27 -0500
Date: Wed, 21 Nov 2001 11:51:26 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111191247050.12469772-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0111211146500.12827068-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, John Jasen wrote:

> Making a more stripped 2.4.14 now, and will post results and .config in
> the same directory as everything else.

ehhh ... same results.

Interestingly enough, a few people posted and emailed that they hade no
problems with their SiS630E chipsets, and offering various theories
therein.

My vendor had a SiS630E board that was going to be RMA'd (broken ps/2 port
for mouse of all damned things), so he quickly built a system around it, I
ssh'ed in, copied over 2.4.14, and make dep took a whopping 37 seconds or
so, with make (on a .config with everything either added in or as a
module) about 6.5 minutes.

So, no, whatever magic molassas infects my SiS630 boards does not seem to
extend to the SiS630E.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

