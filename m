Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTHFQnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270654AbTHFQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:42:20 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:64263 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270652AbTHFQlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:41:13 -0400
Subject: Re: TSCs are a no-no on i386
From: James Bottomley <James.Bottomley@steeleye.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 06 Aug 2003 09:41:11 -0700
Message-Id: <1060188073.2629.2.camel@fuzzy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hopefully there are not too many SMP-486 machines out there ;-).

The mach-voyager subarchitecture code in 2.6 is designed to be able to
boot an SMP 486 system.  I actually have (or rather have the cards to
build) a 5-way 486 system.  (Although the cpu's were all certified as
having correct cmpxchg semantics).

James


