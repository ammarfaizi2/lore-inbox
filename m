Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310241AbSCBB3n>; Fri, 1 Mar 2002 20:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310242AbSCBB3e>; Fri, 1 Mar 2002 20:29:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20051 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310241AbSCBB3b>; Fri, 1 Mar 2002 20:29:31 -0500
Date: Sat, 2 Mar 2002 02:28:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Teodor.Iacob@astral.kappa.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.18 : lots of "state D" processes ....
Message-ID: <20020302022853.E4431@inspiron.random>
In-Reply-To: <20020228183120.C1705@inspiron.school.suse.de> <Pine.LNX.4.31.0203010002100.5620-100000@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0203010002100.5620-100000@linux.kappa.ro>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:03:49AM +0200, Teodor Iacob wrote:
> Ok, I rushed to reply but it seems like I still get the perl process in a
> "D state", no matter if I compile USB as module or built-in, with rmap12g
> or with your patch. Anyway to track this?

SYSRQ+T run on top of 2.4.19pre1aa1 should allow to track down whatever
USB problem it is.

Andrea
