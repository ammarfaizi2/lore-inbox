Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSILQnT>; Thu, 12 Sep 2002 12:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSILQnT>; Thu, 12 Sep 2002 12:43:19 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64426 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S316601AbSILQnT>; Thu, 12 Sep 2002 12:43:19 -0400
Date: Thu, 12 Sep 2002 09:45:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mzielinski@wp-sa.pl
cc: linux-kernel@vger.kernel.org
Subject: Re: unexpected IO-APIC on IBM xSeries 440
Message-ID: <572796648.1031823954@[10.10.2.3]>
In-Reply-To: <1031846309.2838.96.camel@irongate.swansea.linux.org.uk>
References: <1031846309.2838.96.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know what state 2.5 is on Summit numa but 2.4.19-ac and
> 2.4.20pre6 plus one patch (I can bounce you the diff if you want) should
> work nicely on summit chipsets with any distro

2.5 has some problems with interrupts and ACPI that were being
worked around ... the right people here will send you some stuff.

M.

