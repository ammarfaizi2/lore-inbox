Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTFYW43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbTFYW42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:56:28 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:44777 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S265153AbTFYW4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:56:25 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551DA@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.72 doesn't boot
Date: Wed, 25 Jun 2003 17:10:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

It works and great thanks!

Eddie  

> -----Original Message-----
> From: Luck, Tony [mailto:tony.luck@intel.com]
> Sent: Wednesday, June 25, 2003 11:58 AM
> To: yiding_wang@agilent.com
> Subject: Re: 2.5.72 doesn't boot
> 
> 
> I was seeing the same issue.  I also tried the CONFIG_INPUT,
> CONFIG_VGA_CONSOLE etc.  changed that were suggested
> on this list ... with no effect.
> 
> A colleague gave me this ".config" file which worked for him, and
> I made minimal changes using "make menuconfig" to adjust for
> my machine (just cpu type) ... and got a bootable kernel.
> 
> Sadly I forgot to save my original .config file, so I can't see
> what changed.  But you could try to repeat the experiment.
> 
> -Tony Luck  
> 
> 
