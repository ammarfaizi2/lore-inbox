Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbREWWfr>; Wed, 23 May 2001 18:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263301AbREWWff>; Wed, 23 May 2001 18:35:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34841 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263300AbREWWfT>; Wed, 23 May 2001 18:35:19 -0400
Date: Thu, 24 May 2001 00:35:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: eccesys@topmail.de, chris@ludwig-alpha.unil.ch, mblack@csihq.com,
        linux-kernel@vger.kernel.org
Subject: Re: rwsems and asm-constraint gcc bug
Message-ID: <20010524003502.D764@athlon.random>
In-Reply-To: <23545.990620839@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23545.990620839@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Wed, May 23, 2001 at 01:27:19PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 01:27:19PM +0100, David Howells wrote:
> 
> The bug in gcc 3.0 that stopped the inline asm constraints being interpreted
> properly, and thus prevented linux from compiling is now fixed.

I'm writing this on top of 2.4.5pre5aa3 compiled with gcc-3_0-branch and
binutils cvs mainline of this evening. No problem so far. Thanks!

Andrea
