Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266340AbUANOuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUANOuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:50:15 -0500
Received: from amdext2.amd.com ([163.181.251.1]:60045 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S266340AbUANOuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:50:09 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C080EF3A4@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: linux@dominikbrodowski.de
cc: pavel@ucw.cz, davej@redhat.com, mark.langsdorf@amd.com,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: Cleanups for powernow-k8
Date: Wed, 14 Jan 2004 08:49:18 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C1B896541751-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> hardware. Dominik sent me some great patches to use the cpufreq table support 
>> and remove some redundant code - let me know if you do not have them and
>> want me to forward them. They work great.
> 
> I've rediffed them for 2.6.1 and put them here:
> 
> http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_1
> 
> http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_2
> 
> http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_3
> 
> http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_4
> 
> http://www.brodo.de/patches/2004_01_14/powernow-k8-2.6.1-freq_table_5
> 
> Paul: do you agree to them being merged?
> 
> 	Dominik

Absolutely. I am planning on using them also in the new ACPI based driver,
along with your acpi-perflib.

What is your progress on getting acpi-perflib merged into the kernel so that
an additional patch is not needed ?

Paul.


