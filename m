Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUAGH4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUAGH4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:56:49 -0500
Received: from web9502.mail.yahoo.com ([216.136.129.132]:54448 "HELO
	web9502.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265201AbUAGH4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:56:42 -0500
Message-ID: <20040107075641.79874.qmail@web9502.mail.yahoo.com>
Date: Tue, 6 Jan 2004 23:56:41 -0800 (PST)
From: neel vanan <neelvanan@yahoo.com>
Subject: 2.6.0 works with 3.0 Enterprise Linux or not...
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com
In-Reply-To: <1073305477.4429.0.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I had posted my problem in mailing list i didn't get
proper response.
I would like to know whether 2.6.0 works properly with
Enterprise Linux 3.0 or or not. For me it works fine
with RedHat Linux9.0 but same kernel didn't boot with
EL 3.0. Arjan had replied that i have to upgrade some
packages but how many that is mystery. If i have to
upgrade than how many packages i should upgrade. I
have already upgraded mkinitrd and modutils still it
gives this error while booting:

Software Suspend has malfunctioning SMP support.
Disabled :(
ACPI: (supports S0 S1 S4 S5)
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-1 !=32768) 4194304
VFS cannot open root device "LABEL=/" or unknown block
(0,0)
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on
unknown-block(0,0)

I had also tried root=/dev/sda2 and also root=0802.
But still it is not booting.

Help needed urgently, Thanks in advance.

Neel.

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
