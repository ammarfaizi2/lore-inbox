Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRKAA3O>; Wed, 31 Oct 2001 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRKAA3E>; Wed, 31 Oct 2001 19:29:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25186 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276646AbRKAA27>; Wed, 31 Oct 2001 19:28:59 -0500
Date: Thu, 1 Nov 2001 01:29:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Ben Smith <ben@google.com>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011101012931.K1291@athlon.random>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin> <20011031214540.D1291@athlon.random> <E15z5Zm-000067-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15z5Zm-000067-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Nov 01, 2001 at 01:19:15AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 01:19:15AM +0100, Daniel Phillips wrote:
> If it does turn out to be oom, it's still a bug, right?

The testcase I checked a few weeks ago looked correct, so whatever it
is, it should be a kernel bug.

Andrea
