Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272187AbRIESy7>; Wed, 5 Sep 2001 14:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272261AbRIESyr>; Wed, 5 Sep 2001 14:54:47 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:23054 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272187AbRIESyo>; Wed, 5 Sep 2001 14:54:44 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109051900.MAA04249@boojiboy.eorbit.net>
Subject: Solo sound - 2.4.10-pre build fails
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 12:00:51 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop with an ESS solo sound chip.

It has worked from around 2.2.14

I tried compiling 2.4.10-pre4 and
the build fails on the sound code.

Earlier in the build there is an error message
about an invalid pointer.

When I recompile without sound support it
does build successfully.

--Chris

