Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSGRNml>; Thu, 18 Jul 2002 09:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318083AbSGRNml>; Thu, 18 Jul 2002 09:42:41 -0400
Received: from dsl-213-023-043-252.arcor-ip.net ([213.23.43.252]:32968 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318079AbSGRNmk>;
	Thu, 18 Jul 2002 09:42:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Remain Calm: Designated initializer patches for 2.5
Date: Thu, 18 Jul 2002 15:47:07 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020718032331.5A36644A8@lists.samba.org>
In-Reply-To: <20020718032331.5A36644A8@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17VBcZ-0004oO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 05:22, Rusty Russell wrote:
> 	I just sent about 40 reasonable-size patches through the
> Trivial Patch Monkey to Linus: these patches replace the (deprecated)
> "foo: " designated initializers with the ISO-C ".foo =" initializers.
> GCC has understood both since forever, but the kernel took a wrong
> bet, and we're better off setting a good example for 2.6 before we
> start getting about 10,000 warnings.

Next time, remember to bet on the ugliest looking one ;-)

-- 
Daniel
