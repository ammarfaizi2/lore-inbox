Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163793AbWLGXGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163793AbWLGXGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163794AbWLGXGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:06:33 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33058
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1163793AbWLGXGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:06:31 -0500
Date: Thu, 07 Dec 2006 15:06:35 -0800 (PST)
Message-Id: <20061207.150635.07640320.davem@davemloft.net>
To: randy.dunlap@oracle.com
Cc: s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org, akpm@osdl.org,
       jesper.juhl@gmail.com
Subject: Re: [PATCH/RFC] CodingStyle updates
From: David Miller <davem@davemloft.net>
In-Reply-To: <45789D0F.6060100@oracle.com>
References: <20061207004838.4d84842c.randy.dunlap@oracle.com>
	<200612072254.51348.s0348365@sms.ed.ac.uk>
	<45789D0F.6060100@oracle.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Thu, 07 Dec 2006 15:00:31 -0800

> Alistair John Strachan wrote:
> 
> >> +but no space after unary operators:
> >> +		sizeof  ++  --  &  *  +  -  ~  !  defined
> > 
> > You could mention typeof too, which is a keyword but should be done like 
> > sizeof.
> 
> Hm, is that a gcc-ism?  It's not listed in the C99 spec.
> 
> Are there other gcc-isms that I should add?

Perhaps you should add typeof and alignof, for starters.
