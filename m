Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSDSFF1>; Fri, 19 Apr 2002 01:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314558AbSDSFF0>; Fri, 19 Apr 2002 01:05:26 -0400
Received: from epithumia.math.uh.edu ([129.7.128.2]:43992 "EHLO
	epithumia.math.uh.edu") by vger.kernel.org with ESMTP
	id <S314557AbSDSFFZ>; Fri, 19 Apr 2002 01:05:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: AMD 760MPX B2 stepping
In-Reply-To: <000f01c1e659$17abd6e0$d281f6cc@iboats.com>
From: Jason L Tibbitts III <tibbs@math.uh.edu>
Date: 19 Apr 2002 00:05:25 -0500
Message-ID: <ufaelhc5ld6.fsf@epithumia.math.uh.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "SW" == Steve Wolfe <sw@codon.com> writes:

SW> I have been having a devil of a time trying to get SMP to work
SW> with stability on the new B2 stepping of the 760 MPX chipset (Tyan
SW> 2466N-4M motherboard).  Has anyone fiddled with it, and if so, are
SW> there any known bugs?

Just to summarize my discussion with Steve today, I put together a
machine with one of these boards (Tyan Tiger MPX S2466N-4M) with
2xMP1900+ processors and 4x512MB PC2100 registered ECC DIMMs (Corsair
CM73SD512R-2100).  The machine runs fine under concurrent big CPU and
IO loads.  I don't think there's anything inherently wrong with this
board, although I do think these things run rather close to spec and
are sensitive to just about any oddity.

(I also have a bunch of the previous revision of Tyan MPX boards and
they're stable as well.  I never could get the early generation Tiger
MP boards to work at all.)

 - J<
