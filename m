Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263576AbUEKUDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUEKUDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUEKUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:03:20 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:37064 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S263576AbUEKUDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:03:19 -0400
Message-ID: <40A13127.80900@keyaccess.nl>
Date: Tue, 11 May 2004 22:01:43 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lorenzo Allegrucci <l_allegrucci@despammed.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6 IDE drive errors at boot time
References: <200405112110.49192.l_allegrucci@despammed.com>
In-Reply-To: <200405112110.49192.l_allegrucci@despammed.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci wrote:

> hda: Maxtor 6Y060L0, ATA DISK drive

> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: Write Cache FAILED Flushing!

Yup, known, is being worked on by Bartlomiej Zolnierkiewicz/

Rene.
