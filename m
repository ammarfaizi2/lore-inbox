Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266140AbSKFVzm>; Wed, 6 Nov 2002 16:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266150AbSKFVzl>; Wed, 6 Nov 2002 16:55:41 -0500
Received: from [61.11.77.75] ([61.11.77.75]:4337 "EHLO ks.tachyon.tech")
	by vger.kernel.org with ESMTP id <S266140AbSKFVy4>;
	Wed, 6 Nov 2002 16:54:56 -0500
Subject: kdb source level debugging
From: K S Sreeram <ks@sreeram.cc>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Nov 2002 03:07:30 +0530
Message-Id: <1036618678.23495.15.camel@ks>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I am interested in implementing source-level debugging features for kdb.
I know that kgdb already does that, but kgdb is very inconvenient to use
compared to kdb as it requires two systems. Adding source level
debugging to kdb would allow me to understand the kernel source code
much better, since i would be able to trace thru the code and see it in
action.

has any such work already been done before? any tips on how this can be
implemented??

Thanks in Advance

Regards
Sreeram
Tachyon Technologies


