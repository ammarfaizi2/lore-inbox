Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKVNsQ>; Thu, 22 Nov 2001 08:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279505AbRKVNsG>; Thu, 22 Nov 2001 08:48:06 -0500
Received: from t2.redhat.com ([199.183.24.243]:2297 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S279407AbRKVNr6>; Thu, 22 Nov 2001 08:47:58 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0111221437130.22919-100000@dirac.dina.kvl.dk> 
In-Reply-To: <Pine.LNX.4.21.0111221437130.22919-100000@dirac.dina.kvl.dk> 
To: "Thomas S. Iversen" <thomassi@dina.kvl.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XIP linux? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Nov 2001 13:47:20 +0000
Message-ID: <26655.1006436840@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thomassi@dina.kvl.dk said:
>  1. Are there any patches for making linux run from a CF card?

It is an IDE disk. You may think it has flash inside - we couldn't possibly 
comment. As far as the computer is concerned, it is an IDE disk.

> 2. Anybody know anyting about making a XIP linux disk? (all code stays on
> the CF card, only datastructures and the like eat up the little memory
> I have)? 

You can't do XIP from an IDE disk.


--
dwmw2


