Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSDBLmv>; Tue, 2 Apr 2002 06:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSDBLmm>; Tue, 2 Apr 2002 06:42:42 -0500
Received: from kim.it.uu.se ([130.238.12.178]:27636 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S310917AbSDBLm0>;
	Tue, 2 Apr 2002 06:42:26 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15529.39198.444056.901156@kim.it.uu.se>
Date: Tue, 2 Apr 2002 13:42:22 +0200
To: linux-kernel@vger.kernel.org
Subject: UP IO-APIC with ACPI table but no MP table?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to get the kernel to recognise and utilise the
chipset's IO-APIC if the BIOS has no MP table but does list the
IO-APIC in the ACPI table(s)?

If it's possible, is it also meaningful to do this on UP?

/Mikael
