Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSK0OjZ>; Wed, 27 Nov 2002 09:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSK0OjY>; Wed, 27 Nov 2002 09:39:24 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:35748 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S262780AbSK0OjX>;
	Wed, 27 Nov 2002 09:39:23 -0500
Message-ID: <1038408400.3de4dad05ddc6@kolivas.net>
Date: Thu, 28 Nov 2002 01:46:40 +1100
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49-mm2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Compile problem:

drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this function)

Con
