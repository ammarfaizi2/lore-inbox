Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSI2M7u>; Sun, 29 Sep 2002 08:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262467AbSI2M7u>; Sun, 29 Sep 2002 08:59:50 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:50917 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262464AbSI2M7t>; Sun, 29 Sep 2002 08:59:49 -0400
Message-ID: <3D96FAA4.F328E3D5@bigpond.com>
Date: Sun, 29 Sep 2002 23:05:40 +1000
From: Allan Duncan <allan.d@bigpond.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.39APIC i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gabor Z. Papp" <gzp@myhost.mynet>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac3 spurious 8259A interrupt
References: <1333.3d96c7c1.d91c5@gzp1.gzp.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You don't say what chipset the m/b uses.

I see this message once, near boot time, on a VIA KT266A,
unless I use a RedHat patched kernel.  Haven't managed to
find what they did to stop it though.
