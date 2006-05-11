Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWEKTYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWEKTYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWEKTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:24:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:42704 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750731AbWEKTYe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:24:34 -0400
From: Andi Kleen <ak@suse.de>
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Subject: Re: Oops in au8830 driver on x86-64
Date: Thu, 11 May 2006 21:24:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <446271C6.9050509@dunaweb.hu> <p73d5ek76k7.fsf@bragg.suse.de> <44638F21.7020201@dunaweb.hu>
In-Reply-To: <44638F21.7020201@dunaweb.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605112124.47803.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 May 2006 21:23, Zoltan Boszormenyi wrote:
> Hi,
>
> Andi Kleen írta:
> > Zoltan Boszormenyi <zboszor@dunaweb.hu> writes:
> >> I couldn't seek further, I put the card away for now. :-)
> >
> > First thing I would do is to fix all the compile warnings.
> >
> > -Andi
>
> What warnings are you talking about?

It was just a general comment. If there aren't any it's harder.
I guess you would need to find out where exactly it crashes.

-Andi
