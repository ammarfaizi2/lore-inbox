Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbSLLXgf>; Thu, 12 Dec 2002 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbSLLXgf>; Thu, 12 Dec 2002 18:36:35 -0500
Received: from elin.scali.no ([62.70.89.10]:22788 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267543AbSLLXgf>;
	Thu, 12 Dec 2002 18:36:35 -0500
Date: Fri, 13 Dec 2002 00:44:17 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Richard Henderson <rth@twiddle.net>
cc: Matt Reppert <arashi@arashi.yi.org>, <trivial@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] "extern inline" to "static inline" allows compile
In-Reply-To: <20021212152448.A5688@twiddle.net>
Message-ID: <Pine.LNX.4.44.0212130041040.1854-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Richard Henderson wrote:

> On Thu, Dec 12, 2002 at 05:09:02PM -0600, Matt Reppert wrote:
> > Comments?
> 
> Revert the asm/pci.h change instead.
> 

Is there a reason for the 'extern inline', to me it seems more natural to 
have 'static inline' ?

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

