Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJUVht>; Mon, 21 Oct 2002 17:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJUVhq>; Mon, 21 Oct 2002 17:37:46 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:16914 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id <S261726AbSJUVhl>; Mon, 21 Oct 2002 17:37:41 -0400
Date: Mon, 21 Oct 2002 12:15:21 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI problems with 2.5.44 and IBM ThinkPad 390E
Message-ID: <20021021101521.GB349@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

upon trying the latest devel kernel I got periodic messages from ACPI on my IBM ThinkPad 390E (and when I tried ACPI on 2.4.X it seemed to show similar problems). The messages are added below, other than periodic warnings, the /proc/acpi/battery/BAT1/info and status files show faulty charge levels and charge state as unknown. No real showstoppers though.

Regards,
David

PS
If any more info is needed, msg me...please CC me on any reply since I'm not subscribed

[ACPI Debug] String: ------local0.1 = BAT1 PBST modified-----
[ACPI Debug] String: --------------------------------Clear P4.0 : OS-BAT2 
[ACPI Debug] String: --------------------------------BAT2 is not present
[ACPI Debug] String: -------------------BAT1_STA, slot is connected
[ACPI Debug] String: ----------------------------RESTART EC 1S TIMER
[ACPI Debug] String: --------------------------------Set P4.0 : OS-BAT1
[ACPI Debug] String: --------------------------------BAT1 is still present
[ACPI Debug] String: --------------------------------ACCESS UPBI
[ACPI Debug] String: --------------------------------ACCESS UPBS
[ACPI Debug] String: ------local0.0 = BAT1 PBIF modified-----
[ACPI Debug] Integer: 0000000000000002
[ACPI Debug] String: ------local0.1 = BAT1 PBST modified-----
[ACPI Debug] String: --------------------------------Clear P4.0 : OS-BAT2
[ACPI Debug] String: --------------------------------BAT2 is not present
[ACPI Debug] String: -------------------BAT1_STA, slot is connected
[ACPI Debug] String: ----------------------------RESTART EC 1S TIMER
[ACPI Debug] String: --------------------------------Set P4.0 : OS-BAT1
[ACPI Debug] String: --------------------------------BAT1 is still present
[ACPI Debug] String: --------------------------------ACCESS UPBI
[ACPI Debug] String: --------------------------------ACCESS UPBS   
[ACPI Debug] String: ------local0.0 = BAT1 PBIF modified-----
[ACPI Debug] Integer: 0000000000000000
