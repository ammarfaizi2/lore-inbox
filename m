Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSDCLAg>; Wed, 3 Apr 2002 06:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSDCLA0>; Wed, 3 Apr 2002 06:00:26 -0500
Received: from are.twiddle.net ([64.81.246.98]:61080 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S310515AbSDCLAQ>;
	Wed, 3 Apr 2002 06:00:16 -0500
Date: Wed, 3 Apr 2002 03:00:13 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Michal Moskal <malekith@pld.org.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.1 ffs problem, kernel 2.4.18
Message-ID: <20020403030013.A13858@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Michal Moskal <malekith@pld.org.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020402145955.A12932@twiddle.net> <Pine.LNX.4.33.0204021604190.1760-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 04:04:58PM -0800, Linus Torvalds wrote:
> When was __builtin_ffs introduced? I know it didn't use to exist, but 
> we've obviously bumped up the gcc requirements several times, so..

Dunno.  Before egcs forked.


r~
