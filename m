Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751958AbWITRE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWITRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWITRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:04:27 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:34438 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1751958AbWITRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:04:26 -0400
X-IronPort-AV: i="4.09,192,1157342400"; 
   d="scan'208"; a="9869944:sNHT25262762"
Message-Id: <6.1.1.1.0.20060920125855.01eca0c0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 20 Sep 2006 13:04:43 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: drivers/char/random.c exported interfaces
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap said:
>ISTM that we should at least fix the first 2 (by EXPORTing them).
>or we don't allow INPUT=m.
>
>You want to send a patch?

No problem - which patch do you want? (exporting? or set INPUT to bool?)

I'll send the export later tonight if no objections.

-Robin

