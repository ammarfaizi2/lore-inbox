Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbTIMVnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 17:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbTIMVnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 17:43:51 -0400
Received: from mail2-116.ewetel.de ([212.6.122.116]:45303 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S262221AbTIMVnt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 17:43:49 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <vq84.1P5.7@gated-at.bofh.it>
References: <vpYm.1Bn.7@gated-at.bofh.it> <vq84.1P5.7@gated-at.bofh.it>
Date: Sat, 13 Sep 2003 23:43:44 +0200
Message-Id: <E19yIBE-0000nO-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 23:30:12 +0200, you wrote in linux.kernel:

>> If people put GPL_ONLY symbol exports in their code, that's their call
>> to make, is it not? It's their code and they're free to say "well, this
>> is my code, and if you use this symbol, I consider your stuff to be a
>> derived work". Once again it's up to the lawyers to decide whether
>> this has legal value or not.
> 	If it has legal value, then it's an additional restriction.

Derived works are already restricted (when it comes to distributing them,
otherwise none of this is relevant since you can easily locally make
all EXPORT_SYMBOL_GPL be plain EXPORT_SYMBOL). It would be a restriction
on who gets to say what constitutes a derived work and what not - but
that is not governed by the GPL anyway but by the relevant local laws.

The GPL does not and cannot outrank the law. If the law were to say the
authors of a piece of code get to say what is a derived work and what
not, then so it is and nothing the GPL says can stand against it.

-- 
Ciao,
Pascal
