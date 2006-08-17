Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWHQIgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWHQIgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWHQIgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:36:16 -0400
Received: from hermes.domdv.de ([193.102.202.1]:34317 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S932455AbWHQIgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:36:15 -0400
Message-ID: <44E42A4C.4040100@domdv.de>
Date: Thu, 17 Aug 2006 10:35:24 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Willy Tarreau <w@1wt.eu>, Adrian Bunk <bunk@stusta.de>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
References: <20060816223633.GA3421@hera.kernel.org>	 <20060816235459.GM7813@stusta.de>  <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org>
In-Reply-To: <1155797331.4494.17.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> But maybe it's worth doing a user survey to find out what the users of
> 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
> people who use enterprise distro kernels don't count for this since
> they'll not go to a newer released 2.4 anyway)

Currently I'm working with ARM based embedded systems. I prefer 2.4
kernels to 2.6 as they are smaller thus leaving more flash for jffs2.
Not speaking of the kernel a gcc 4.1.1 compile of code for a LPC2103
resulted in a clearly smaller binary as the same compile with gcc 3.4.
Thus I really would like to be able to use gcc 4.x with 2.4 kernels.
There are even kernel miscompiles with gcc 3.4 that might be fixed with
gcc 4 (one has to try).
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
