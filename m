Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRIJLR4>; Mon, 10 Sep 2001 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJLRq>; Mon, 10 Sep 2001 07:17:46 -0400
Received: from petasus.iil.intel.com ([192.198.152.69]:22524 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S270523AbRIJLRh>; Mon, 10 Sep 2001 07:17:37 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B27313@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Developing code for ia64
Date: Mon, 10 Sep 2001 14:17:53 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When developing kernel drivers (module) for ia64, is it necessary to do it
on an ia64 machine ?
Our product contains a pre-compiled core object (IP protection :-\ ) and a
set of wrapper source files, so for dual platform support the tar ball has
to contain both an ia32 and ia64 versions of the executable. Is there any
way to get an ia64 compiler (and libs) installed on an ia32 machine and use
it to get ia64 compatible binaries ?


	Thanks,
	Shmulik Hen
	Software Engineer
	Linux Advanced Networking Services
	Network Communications Group, Israel (NCGj)
	Intel Corporation Ltd.

