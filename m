Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWFGQNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWFGQNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWFGQNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 12:13:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:50846 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932284AbWFGQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 12:13:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RmmFAH10UuLURLR96AyXQADvN0duS/UGFX4T/UeJCAkASkScnLfamDykTCAGJVtG9AyVC/P/nAJ/ab9gni/oA3k+sPflwFEHlJtl9sXoYlvhM4K6eIUlkAKaMm2iaNxa1VN6nbGCrHjm8s9ot+d8m7QnCHvK+x7KZNtSSpWB5O8=
Message-ID: <728201270606070913g2a6b23bbj9439168a1d8dbca8@mail.gmail.com>
Date: Wed, 7 Jun 2006 16:13:36 +0000
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: booting without initrd
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to boot with 2.6.16  kernel at my desktop running fedora
core 4 . It does not boot without initrd generating the message "VFS:
can not open device "804" or unknown-block(8,4)
Please append a correct "root=" boot option
Kernel panic - not syncing : VFS:Unable to mount root fs on unknown-block(8,4)

I have disabled the module support & built in all modules/drivers for
ide/scsi/sata but it does not boot. I have to disable the module as I
need a statically built  kernel.

If someone could describe the way to boot without initrd it will be great.

Thanks in advance for your cooperation.
Ram Gupta
