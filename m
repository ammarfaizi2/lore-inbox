Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbSLLXRD>; Thu, 12 Dec 2002 18:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbSLLXRD>; Thu, 12 Dec 2002 18:17:03 -0500
Received: from are.twiddle.net ([64.81.246.98]:23681 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267546AbSLLXRC>;
	Thu, 12 Dec 2002 18:17:02 -0500
Date: Thu, 12 Dec 2002 15:24:48 -0800
From: Richard Henderson <rth@twiddle.net>
To: Matt Reppert <arashi@arashi.yi.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "extern inline" to "static inline" allows compile
Message-ID: <20021212152448.A5688@twiddle.net>
Mail-Followup-To: Matt Reppert <arashi@arashi.yi.org>,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <20021212170902.34e344b1.arashi@arashi.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021212170902.34e344b1.arashi@arashi.yi.org>; from arashi@arashi.yi.org on Thu, Dec 12, 2002 at 05:09:02PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 05:09:02PM -0600, Matt Reppert wrote:
> Comments?

Revert the asm/pci.h change instead.


r~
