Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131742AbQK2T6j>; Wed, 29 Nov 2000 14:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131735AbQK2T63>; Wed, 29 Nov 2000 14:58:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22612 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S130833AbQK2T6T>; Wed, 29 Nov 2000 14:58:19 -0500
Date: Wed, 29 Nov 2000 20:27:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001129202728.A811@athlon.random>
In-Reply-To: <20001129195630.A6006@athlon.random> <Pine.LNX.4.21.0011291704140.5302-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0011291704140.5302-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Nov 29, 2000 at 05:05:20PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 05:05:20PM -0200, Rik van Riel wrote:
> To be honest, I have a big problem with micro optimisations
> that prevent the big optimisations from happening.
> 
> Would it be an idea to explicitly comment such dangerous
> micro optimisations so people implementing the big optimisations
> later on won't run into nasty surprises?

Did you read the code we're talking about?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
