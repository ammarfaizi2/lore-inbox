Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUJFNhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUJFNhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJFNhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:37:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269132AbUJFNhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:37:35 -0400
Date: Wed, 6 Oct 2004 15:37:13 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'C' calling convention change.
Message-ID: <20041006133713.GA4434@devserv.devel.redhat.com>
References: <Pine.LNX.4.61.0410060816430.3420@chaos.analogic.com> <1097068610.2812.19.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410060932200.13111@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410060932200.13111@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:34:43AM -0400, Richard B. Johnson wrote:
> 
> Well I'm trying to port some drivers. I thought those were

url?

> kernel thingies. Also, the kernel is so connected  with gcc-isms
> that it's kinda important.

just mark them asmlinkage and the usual clobber rules apply.
