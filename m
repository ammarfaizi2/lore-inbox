Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSJKC0O>; Thu, 10 Oct 2002 22:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbSJKC0O>; Thu, 10 Oct 2002 22:26:14 -0400
Received: from are.twiddle.net ([64.81.246.98]:50605 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262322AbSJKC0O>;
	Thu, 10 Oct 2002 22:26:14 -0400
Date: Thu, 10 Oct 2002 19:31:56 -0700
From: Richard Henderson <rth@twiddle.net>
To: alan@cotse.com
Cc: phil-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Patches from Redhat gcc 3.2
Message-ID: <20021010193156.C20648@twiddle.net>
Mail-Followup-To: alan@cotse.com, phil-list@redhat.com,
	linux-kernel@vger.kernel.org
References: <YWxhbg==.35e5d37d477d0ddc01cb3484f9ef3349@1034183288.cotse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <YWxhbg==.35e5d37d477d0ddc01cb3484f9ef3349@1034183288.cotse.net>; from alan@cotse.net on Wed, Oct 09, 2002 at 01:08:08PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 01:08:08PM -0400, Alan Willis wrote:
>   Which of the 69 patches in the redhat gcc-3.2 rpm from RH8 provide the
> functionality needed for the __thread keyword...

The ones with "tls" in the title.  There were at least 5 the last time
I checked.  Alternaltly, check out either gcc-3_2-rhl8-branch or mainline
from gcc.gnu.org.


r~
