Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTE0T0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTE0T0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:26:33 -0400
Received: from smtp0.libero.it ([193.70.192.33]:52121 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S264081AbTE0T0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:26:31 -0400
Date: Tue, 27 May 2003 21:39:57 +0200
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] HZ entry in /proc/sys/kernel
Message-ID: <20030527193957.GA288@libero.it>
References: <1053950030.2028.4.camel@nalesnik.localhost> <1053951356.32566.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053951356.32566.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
From: Daniele <dandario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 02:15:57PM +0200, Arjan van de Ven wrote:
> On Mon, 2003-05-26 at 13:53, Grzegorz Jaskiewicz wrote:
> > I have seen few scripts allready that are assuming HZ==100.
> > Afaik this value is different in 2.5/2.4 for the same arch.
> 
> No it's not actually.
> The userspace interface is constant/stable and in units of HZ=100 even
> though the kernel HZ might be different.
> 

What's this HZ value related to?
cheers,
	Daniele
