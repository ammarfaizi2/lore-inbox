Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132777AbRDQXM2>; Tue, 17 Apr 2001 19:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRDQXMT>; Tue, 17 Apr 2001 19:12:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53778 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132777AbRDQXMF>; Tue, 17 Apr 2001 19:12:05 -0400
Subject: Re: IP Acounting Idea for 2.5
To: md-linux-kernel@logi.cc (Manfred Bartz)
Date: Wed, 18 Apr 2001 00:13:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010417225850.15245.qmail@logi.cc> from "Manfred Bartz" at Apr 18, 2001 08:58:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pef6-0003Vj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fix your userspace applications to behave correctly.  If _you_
> > require your userspace applications to not clear counters, then fix
> > the application.
> 
> You are confused.  What would you say if a close() by another,

No he isnt confused, you are trying to dictate policy.

> unrelated application closed all open descriptors for that file,
> including the one you just opened?  Just fix your applications?

That would be a bug. The standards and common sense say so, but your argument
is more akin to 'if I delete a file in one app it hurts when I try and use
it in another'.


