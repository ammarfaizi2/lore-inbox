Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163734AbWLGXPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163734AbWLGXPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163892AbWLGXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:15:00 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:61622 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163879AbWLGXO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:14:58 -0500
Date: Thu, 7 Dec 2006 15:15:22 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David Miller <davem@davemloft.net>
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
Message-Id: <20061207151522.1b429966.randy.dunlap@oracle.com>
In-Reply-To: <20061207.150635.07640320.davem@davemloft.net>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
	<200612072254.51348.s0348365@sms.ed.ac.uk>
	<45789D0F.6060100@oracle.com>
	<20061207.150635.07640320.davem@davemloft.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 15:06:35 -0800 (PST) David Miller wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> Date: Thu, 07 Dec 2006 15:00:31 -0800
> 
> > Alistair John Strachan wrote:
> > 
> > >> +but no space after unary operators:
> > >> +		sizeof  ++  --  &  *  +  -  ~  !  defined
> > > 
> > > You could mention typeof too, which is a keyword but should be done like 
> > > sizeof.
> > 
> > Hm, is that a gcc-ism?  It's not listed in the C99 spec.
> > 
> > Are there other gcc-isms that I should add?
> 
> Perhaps you should add typeof and alignof, for starters.

OK, I added both of those.  Thanks.

Will resend soon.
---
~Randy
