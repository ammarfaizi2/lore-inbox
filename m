Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSKVKPF>; Fri, 22 Nov 2002 05:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSKVKPF>; Fri, 22 Nov 2002 05:15:05 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:33204 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261398AbSKVKPF>; Fri, 22 Nov 2002 05:15:05 -0500
Message-Id: <4.3.2.7.2.20021122111645.00b50ea0@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 22 Nov 2002 11:22:20 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Interrupts problem with 3com network cards on dual-cpu systems
  ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the Suse distro enables ACPI by default, I would try booting
with "acpi=off noapic". (Plays hell with my P2 UP)
If that doesn't help, switch the kernel to "SMP-4GB" instead of "SMP-64GB".

Margit 

