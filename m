Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVAVVnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVAVVnd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbVAVVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:43:32 -0500
Received: from itapoa.terra.com.br ([200.154.55.227]:34981 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP id S262752AbVAVVna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 16:43:30 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 567bd60f227d7be9212f5d5a1d022248
Message-ID: <41F2C904.9040004@terra.com.br>
Date: Sat, 22 Jan 2005 18:43:32 -0300
From: Camilo Telles <camilot@terra.com.br>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CELERON D Prescott Step C-0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sirs,

There is a bug in the CELERON D Prescott C-0 that prevents this
processor to reboot the machine. This processor hangs when you try to
reboot the machine. The people from ECS had already released in
2005/01/11 a BIOS update that covers this problem to the motherboard
648FX-A2(PCB:1.0).
Here is the update description of the BIOS:

"1. Add support Prescott E0, C0 stepping CPU
2. Update Prescott CPU Micro code
3. Patch some Prescott 2.4G CPU (FSB533/1M) cannot restart under WinXP"

And Microsoft have released a workaround for this problem too:

"(KB885626)
This non-security critical update helps resolve an issue where a
limited number of systems running a BIOS without production support for
Intel Pentium 4 and Intel Celeron D processors based on Prescott C-0
stepping can potentially hang on Windows XP Service Pack 2
installation."

Maybe someone from Intel can point to us where is the fix or errata of this
problem? I wan´t to create a patch to workaround this issue.
I´m having some problems with this processor using motherboards
from MSI - 661FM-L.

Thanks.

Camilo
