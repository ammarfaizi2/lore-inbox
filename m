Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279838AbRKILlS>; Fri, 9 Nov 2001 06:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279832AbRKILlI>; Fri, 9 Nov 2001 06:41:08 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:60123 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S279838AbRKILk5>; Fri, 9 Nov 2001 06:40:57 -0500
Message-ID: <000d01c16914$195444e0$0c01a8c0@vaio>
From: "Robert Lowery" <cangela@bigpond.net.au>
To: <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Assertion failure wth ext3 on standard Redhat 7.2 kernel
Date: Fri, 9 Nov 2001 22:45:58 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >It looks like memory corruption of some form - a structure
> >member has an impossible value. Are you using any less-than-mainstream
> >device drivers in that box?
P.S. The problem occurs on a completely virgin Redhat 7.2 install as well as
after I have applied all available updates. (after a few crashes and reboots
while applying them).

-Robert

