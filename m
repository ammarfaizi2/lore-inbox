Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281029AbRKCT7a>; Sat, 3 Nov 2001 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281031AbRKCT7U>; Sat, 3 Nov 2001 14:59:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:5562 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S281030AbRKCT7I>;
	Sat, 3 Nov 2001 14:59:08 -0500
Date: Sat, 3 Nov 2001 11:59:00 -0800
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: csr21@cam.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: SPARC and SA_SIGINFO signal handling
Message-ID: <20011103115900.B5984@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, csr21@cam.ac.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011029190027.A21372@cam.ac.uk> <20011030.125134.93645850.davem@redhat.com> <20011031094342.A27520@cam.ac.uk> <20011031.021131.74751566.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031.021131.74751566.davem@redhat.com>; from davem@redhat.com on Wed, Oct 31, 2001 at 02:11:31AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 02:11:31AM -0800, David S. Miller wrote:
> The "register contents and so on" are in the sigcontext.
> We don't use ucontext on sparc32.

In other words, you don't support SA_SIGINFO at all.


r~
