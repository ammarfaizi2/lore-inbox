Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270915AbRHNWrr>; Tue, 14 Aug 2001 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270912AbRHNWrh>; Tue, 14 Aug 2001 18:47:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:14656 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270915AbRHNWrY>; Tue, 14 Aug 2001 18:47:24 -0400
Date: Wed, 15 Aug 2001 00:47:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: poll change - nevermind
Message-ID: <20010815004724.B4304@athlon.random>
In-Reply-To: <3B799358.38EF3B72@sun.com> <3B79A01B.4AB045A8@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B79A01B.4AB045A8@sun.com>; from thockin@sun.com on Tue, Aug 14, 2001 at 03:03:07PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 03:03:07PM -0700, Tim Hockin wrote:
> Tim Hockin wrote:
> 
> > poll() currently does not allow you to pass more fd's than you have 
> 
> I'll shut up - I was looking at 2.2.x source.

btw, it is also fixed in my 2.2 tree since 2.2.20pre8aa1:

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre8aa1/00_poll-max_fds-1

Andrea
