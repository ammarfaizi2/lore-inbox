Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbVLFEje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbVLFEje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbVLFEje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:39:34 -0500
Received: from ozlabs.org ([203.10.76.45]:20957 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751624AbVLFEje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:39:34 -0500
Subject: Re: Two module-init-
From: Rusty Russell <rusty@rustcorp.com.au>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, vojtech@suse.cz
In-Reply-To: <d120d5000512051347u1d77aabam2b70ef91d8709f39@mail.gmail.com>
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
	 <200512022319.05246.dtor_core@ameritech.net>
	 <200512022328.29182.dtor_core@ameritech.net>
	 <1133691865.30188.24.camel@localhost.localdomain>
	 <d120d5000512051347u1d77aabam2b70ef91d8709f39@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 15:39:32 +1100
Message-Id: <1133843972.17208.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 16:47 -0500, Dmitry Torokhov wrote:
> It's not like swbit is new in 2.6.15, it was there since 2.6.14
> was opened.

Err, yeah, good point.  I had assumed this was new in 2.6.14.  Since
we've only seen reports now, I'll assume it's low priority and we can
wait until 2.6.16.

I have a cunning plan to fix module-init-tools in the meantime; expect a
release if it works out...

Thanks all!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

