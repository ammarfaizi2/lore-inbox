Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131115AbRCGQll>; Wed, 7 Mar 2001 11:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131111AbRCGQlW>; Wed, 7 Mar 2001 11:41:22 -0500
Received: from pucc.Princeton.EDU ([128.112.129.99]:49179 "EHLO
	pucc.Princeton.EDU") by vger.kernel.org with ESMTP
	id <S131110AbRCGQlJ>; Wed, 7 Mar 2001 11:41:09 -0500
To: linux-kernel@vger.kernel.org
From: Neale.Ferguson@softwareAG-usa.com
Date: Wed, 7 Mar 2001 11:38:54 +0200
Subject: Problem building m4
Message-Id: <20010307164111Z131110-407+2258@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When building m4 I get the following:

cd . && aclocal -I acm4
aclocal: configure.in: 116: macro `AM_GNU_GETTEXT' not found in library
make: *** çaclocal.m4Ÿ Error 1

Anyone familiar with this?

