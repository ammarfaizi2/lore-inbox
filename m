Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWBLOi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWBLOi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 09:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWBLOi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 09:38:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:42147 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751135AbWBLOi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 09:38:58 -0500
Date: Sun, 12 Feb 2006 15:38:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: xose.vazquez@gmail.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: old patches in -mm
In-Reply-To: <20060212024508.117d4603.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0602121537270.1213@yvahk01.tjqt.qr>
References: <43EE415F.2000805@gmail.com> <Pine.LNX.4.61.0602121134170.25363@yvahk01.tjqt.qr>
 <20060212024508.117d4603.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 2.6-sony_acpi4.patch
>> Forgotten, I think. This one showed no problems for me until now.
>
>The ACPI guys don't like machine-specific drivers like this, apparently -
>features are supposed to be controlled via the machine's BIOS ACPI methods.
>
>But given the state of Sony ACPI documentaion (ie: none) that might not
>work out.  I'll ask about it.
>
If they come up with a better implementation, I would be glad to
assist testing.


Jan Engelhardt
-- 
