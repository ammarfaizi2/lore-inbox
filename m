Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbRDDPO3>; Wed, 4 Apr 2001 11:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRDDPOI>; Wed, 4 Apr 2001 11:14:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:29301 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132838AbRDDPNe>; Wed, 4 Apr 2001 11:13:34 -0400
Date: Wed, 4 Apr 2001 17:12:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: mingo@elte.hu, Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
Message-ID: <20010404171227.W20911@athlon.random>
In-Reply-To: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com>; from frankeh@us.ibm.com on Wed, Apr 04, 2001 at 10:03:10AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 10:03:10AM -0400, Hubertus Franke wrote:
> I understand the dilemma that the Linux scheduler is in, namely satisfy
> the low end at all cost. [..]

We can satisfy the low end by making the numa scheduler at compile time (that's
what I did in my patch at least).

Andrea
