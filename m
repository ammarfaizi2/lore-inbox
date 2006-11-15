Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966751AbWKOK2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966751AbWKOK2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966752AbWKOK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:28:29 -0500
Received: from www.osadl.org ([213.239.205.134]:13229 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S966751AbWKOK23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:28:29 -0500
Subject: Re: 2.6.19-rc5-mm2 -- 3d slow with dynticks
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
References: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 11:31:05 +0100
Message-Id: <1163586665.8335.334.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 23:56 +0100, Benoit Boissinot wrote:
> On 11/14/06, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
> >
> 
> CONFIG_NO_HZ=y still gives me slow 3d games on this one whereas
> 2.6.19-rc5-mm1 +
> http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff was fine.
> 
> Maybe some patches where not merged ?

I just checked. They are all in -mm2.

	tglx


