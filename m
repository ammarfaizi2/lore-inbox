Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265860AbRF2L1i>; Fri, 29 Jun 2001 07:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265861AbRF2L12>; Fri, 29 Jun 2001 07:27:28 -0400
Received: from [213.98.126.44] ([213.98.126.44]:16774 "HELO trasno.mitica")
	by vger.kernel.org with SMTP id <S265860AbRF2L1U>;
	Fri, 29 Jun 2001 07:27:20 -0400
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <200106290322.EAA04600@mauve.demon.co.uk>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <200106290322.EAA04600@mauve.demon.co.uk>
Date: 29 Jun 2001 13:27:38 +0200
Message-ID: <m2ithfr0et.fsf@mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "ian" == Ian Stirling <root@mauve.demon.co.uk> writes:

Hi

ian> It would be nice to show driver version for every single non-stock
ian> driver we load though.
ian> Perhaps a list of versions in the stock kernel build, stored somewhere,
ian> that shouldn't be patched by anyone, but only change with official releases.
ian> At compile time, if the driver version string is different from the
ian> 'blessed' version, it prints it's version, and possibly more.

Don't work, because the kernels in distributions are heavily patched,
and for the distribution the driver that counts is the one that is in
in the distribution, not the one in standard kernel.  I think that
this is overengenering and not too useful :(

Later, Juan.


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
