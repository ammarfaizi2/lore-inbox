Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWIMAQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWIMAQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWIMAQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:16:29 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18577 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030213AbWIMAQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:16:28 -0400
Date: Tue, 12 Sep 2006 18:16:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: speedstep-centrino broke
In-reply-to: <fa.n6wKA2RBQqEJ2ZVU49en3GO739E@ifi.uio.no>
To: Ben B <kernel@bb.cactii.net>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Message-id: <45074DD7.3000204@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.n6wKA2RBQqEJ2ZVU49en3GO739E@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben B wrote:
> Hi,
> 
> My HP notebook decided that its BIOS upgrade would break
> speedstep-centrino, and trying to load the module gives me a "no such
> device" error. This is with various combinations of kernel config
> relating to cpufreq. Also tried acpi-cpufreq with the same error.
> 
> I suspect that the new bios is broken, but perhaps it's correct and the
> linux driver is missing something?

Did this part below show up with the previous BIOS?

> [17179571.248000] ACPI: Subsystem revision 20060127
> [17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C341 (name not of form _Lxx or _Exx) [20060127]
> [17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C23A (name not of form _Lxx or _Exx) [20060127]
> [17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C342 (name not of form _Lxx or _Exx) [20060127]
> [17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C343 (name not of form _Lxx or _Exx) [20060127]
> [17179571.248000] ACPI Error (evgpeblk-0284): Unknown GPE method type: C26F (name not of form _Lxx or _Exx) [20060127]

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

