Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRJEVLA>; Fri, 5 Oct 2001 17:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274041AbRJEVKu>; Fri, 5 Oct 2001 17:10:50 -0400
Received: from are.twiddle.net ([64.81.246.98]:54433 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S274035AbRJEVKh>;
	Fri, 5 Oct 2001 17:10:37 -0400
Date: Fri, 5 Oct 2001 14:10:53 -0700
From: Richard Henderson <rth@twiddle.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Henderson <rth@dot.cygnus.com>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.11-pre3: delay disabling early boot messages
Message-ID: <20011005141053.A14712@twiddle.net>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Richard Henderson <rth@dot.cygnus.com>, torvalds@transmeta.com,
	alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011004183415.A6357@dot.cygnus.com> <17968.1002265943@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17968.1002265943@redhat.com>; from dwmw2@infradead.org on Fri, Oct 05, 2001 at 08:12:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 08:12:23AM +0100, David Woodhouse wrote:
> I've wanted this on other platforms too - couldn't we add an 
> unregister_boot_console() to console_init() instead?

Seems reasonable.  I wouldn't want to touch such a 
think in 2.4 though.


r~
