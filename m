Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTEHCvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 22:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTEHCvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 22:51:45 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:24770 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263087AbTEHCvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 22:51:44 -0400
Message-ID: <3EB9D625.1060704@blue-labs.org>
Date: Wed, 07 May 2003 23:59:33 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dell Inspiron 8200, 2.5.69, ACPI problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI: AC Adapter [AC] (on-line)
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
    ACPI-0207: *** Warning: Buffer created with zero length in AML
ACPI: Battery Slot [BAT0] (battery present)
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
    ACPI-0207: *** Warning: Buffer created with zero length in AML
        -0091: *** Error: ut_allocate: Attempt to allocate zero bytes
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Lid Switch [LID]
ACPI: Power Button (CM) [PBTN]
ACPI: Sleep Button (CM) [SBTN]
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
ACPI: Thermal Zone [THM] (25 C)


