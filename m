Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310515AbSCVVTF>; Fri, 22 Mar 2002 16:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312844AbSCVVSz>; Fri, 22 Mar 2002 16:18:55 -0500
Received: from [195.163.186.27] ([195.163.186.27]:27532 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S310515AbSCVVSw>;
	Fri, 22 Mar 2002 16:18:52 -0500
Date: Fri, 22 Mar 2002 23:18:51 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ORBZ is dead, don't use it...
Message-ID: <20020322231851.C27741@mea-ext.zmailer.org>
In-Reply-To: <20020322225305.B27741@mea-ext.zmailer.org> <Pine.LNX.4.44.0203221303400.1434-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 01:05:39PM -0800, Davide Libenzi wrote:
> On Fri, 22 Mar 2002, Matti Aarnio wrote:
....
> >   I see both DNS lookup timeouts, and SERVFAIL returns.
> >   In my books neither should lead to rejection, but
> >   a) others may have better wisdom that I have,
> >   b) some popular software are known to be unable to
> >      separate any sort of temporary failures (timeouts
> >      at DNS lookup) from real things (actual DNS-RBL)
> 
> Only positive lookups should lead to rejection, IMHO. Timeouts & Co.
> should default to acception.

  Teach sendmail to differentiate the cases...
  (and qmail, and ...)

> - Davide

/Matti Aarnio
