Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSLLXoo>; Thu, 12 Dec 2002 18:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSLLXoo>; Thu, 12 Dec 2002 18:44:44 -0500
Received: from are.twiddle.net ([64.81.246.98]:25985 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264919AbSLLXoo>;
	Thu, 12 Dec 2002 18:44:44 -0500
Date: Thu, 12 Dec 2002 15:52:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: Steffen Persvold <sp@scali.com>
Cc: Matt Reppert <arashi@arashi.yi.org>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "extern inline" to "static inline" allows compile
Message-ID: <20021212155226.A5744@twiddle.net>
Mail-Followup-To: Steffen Persvold <sp@scali.com>,
	Matt Reppert <arashi@arashi.yi.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20021212152448.A5688@twiddle.net> <Pine.LNX.4.44.0212130041040.1854-100000@sp-laptop.isdn.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212130041040.1854-100000@sp-laptop.isdn.scali.no>; from sp@scali.com on Fri, Dec 13, 2002 at 12:44:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 12:44:17AM +0100, Steffen Persvold wrote:
> Is there a reason for the 'extern inline', to me it seems more natural to 
> have 'static inline' ?

Yes.  Examine the entire __EXTERN_INLINE structure with
core_foo.[ch].


r~
