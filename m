Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUCHAMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUCHAMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:12:15 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:19412 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262353AbUCHAML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:12:11 -0500
To: Paul Jackson <pj@sgi.com>
Cc: kangur@polcom.net, mmazur@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
	<m3brnb8bxa.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
	<m38yidk3rg.fsf@defiant.pm.waw.pl>
	<20040306171535.5cbf2494.pj@sgi.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 07 Mar 2004 20:00:15 +0100
In-Reply-To: <20040306171535.5cbf2494.pj@sgi.com> (Paul Jackson's message of
 "Sat, 6 Mar 2004 17:15:35 -0800")
Message-ID: <m38yiclby8.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> Changing kernel config should never change the API.
>
> Linux would be in pretty sad shape if that held.
>
> Incompatible API changes should be rare, but they are an essential part
> of our continuing healthy evolution.  In particular, there's a _long_
> list of hardware devices that have at some time or other worked on
> Linux, but don't anymore - usually because no one is still maintaining
> the driver needed.  But sometimes other API's have to change or
> disappear as well.

You're talking about the kernel development while I meant changing
kernel configuration. They're very distant things.

And note that it's all about C API and not about some API between
different parts of the kernel.
-- 
Krzysztof Halasa, B*FH
