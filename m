Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130557AbQKPPOa>; Thu, 16 Nov 2000 10:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQKPPOU>; Thu, 16 Nov 2000 10:14:20 -0500
Received: from hera.cwi.nl ([192.16.191.1]:12690 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130557AbQKPPOR>;
	Thu, 16 Nov 2000 10:14:17 -0500
Date: Thu, 16 Nov 2000 15:44:07 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 truncate() change broke `dd'
Message-ID: <20001116154407.A28225@veritas.com>
In-Reply-To: <200011161132.MAA26011@harpo.it.uu.se> <Pine.GSO.4.21.0011160637290.11017-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0011160637290.11017-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Nov 16, 2000 at 06:53:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 06:53:30AM -0500, Alexander Viro wrote:

> > I didn't know about notrunc. Yet another GNU invention?
> 
> Maybe, but I doubt it. Anyway, it made its way into 4.4BSD, it's present
> in Solaris, it's in SuS and AFAIK in POSIX.

Yes (for 1003.2-1992).
It is not in 4.3BSD.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
