Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281735AbRKSE4P>; Sun, 18 Nov 2001 23:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281889AbRKSE4F>; Sun, 18 Nov 2001 23:56:05 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:63465 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281804AbRKSEz7>;
	Sun, 18 Nov 2001 23:55:59 -0500
Date: Sun, 18 Nov 2001 23:55:58 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111182144150.12243284-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0111182353520.12243284-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some people have asked about lspci -v giving differing output between
2.2.19 and 2.4.12, and I've just confirmed that /sbin/lspci -v is
identical when the systems are running the same kernel revision.

[I have three systems running the same board, two are identical, and I've
been using one as a 2.2.19 RH baseline against the 2.4.x lame duck for
analysis]

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

