Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWISIwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWISIwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWISIwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:52:15 -0400
Received: from mail.gmx.de ([213.165.64.20]:36835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751639AbWISIwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:52:15 -0400
X-Authenticated: #14349625
Subject: Re: patch blocked
From: Mike Galbraith <efault@gmx.de>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1158654797.3526.14.camel@localhost.localdomain>
References: <1158654797.3526.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 11:03:55 +0000
Message-Id: <1158663835.6137.2.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 16:33 +0800, Zang Roy-r61911 wrote:
> Hi,
> 	Does anyone can tell me why some of my patches were blocked in the
> mailing list.
> 	I do not use attachment. The body of the mail is not exceed 40KB in
> size.
> Roy

A snippet from the 'Bogofilter at VGER' announcment:

...

IF we take it into use, it will start rejecting messages
at SMTP input phase, so if it rejects legitimate message,
you should get a bounce from your email provider's system.
(Or from zeus.kernel.org, which is vger's backup MX.)

In such case, send the bounce with some explanations to 
<postmaster@vger.kernel.org> -- emails to that address
are explicitely excluded from all filtering!


