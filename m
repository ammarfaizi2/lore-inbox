Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265566AbTFZLii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265567AbTFZLii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:38:38 -0400
Received: from [203.124.166.107] ([203.124.166.107]:24331 "EHLO
	mail.pune.nevisnetworks.com") by vger.kernel.org with ESMTP
	id S265566AbTFZLih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:38:37 -0400
content-class: urn:content-classes:message
Subject: RE: INIT:ld"2" respawning too fast:disabled for 5 minutes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jun 2003 17:23:55 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Message-ID: <36993D449C7FA647BF43568E0793AB3E059BC2@nevis_pune_xchg.pune.nevisnetworks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: INIT:ld"2" respawning too fast:disabled for 5 minutes
Thread-Index: AcM7zd0ra2D8JgflSNmPI7GjGHmMoAAC5mQA
From: "Girish Kale" <girish.kale@nevisnetworks.com>
To: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using 2.4.21 kernel. Sending it separately to you.

Regards,
Girish


-----Original Message-----
From: Zeno R.R. Davatz [mailto:zdavatz@ywesee.com] 
Sent: Thursday, June 26, 2003 3:55 PM
To: linux-kernel@vger.kernel.org
Subject: Re: INIT:ld"2" respawning too fast:disabled for 5 minutes

On Thu, 26 Jun 2003 15:31:29 +0530
"Girish Kale" <girish.kale@nevisnetworks.com> wrote:

> When I experimented with my new kernel I added another entry in my
> grub file. That gave me 2 options - to load from my previous kernel or
> to load from my new kernel. So everytime things went wrong with my new
> kernel I booted from the new kernel (which was always intact, not
> overwritten by the new kernel), made modifications for the new kernel
> and then tried out with the new kernel.

Okay, I will try that.

NB: I get the same error with the Debian Kernel-Source-2.4.20...

Can you send me your .config file?

I attached mine.

Thanks
Zeno
