Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVKWPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVKWPt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKWPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:49:26 -0500
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:21177 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751109AbVKWPtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:49:25 -0500
X-IronPort-AV: i="3.97,364,1125892800"; 
   d="scan'208"; a="526970247:sNHT22724440"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.36727.292359.580832@smtp.charter.net>
Date: Wed, 23 Nov 2005 10:49:11 -0500
From: "John Stoffel" <john@stoffel.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
In-Reply-To: <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	<20051122204918.GA5299@kroah.com>
	<9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	<20051123121726.GA7328@ucw.cz>
	<9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> My system has:
Jon> 2 serial
Jon> 1 parallel
Jon> 1 floppy
Jon> 1 gameport
Jon> 1 joystick
Jon> 2 PS/2
Jon> 2 VGA
Jon> 1 HPET
Jon> 1 RTC

Can you post the dmesg output of your bootup?  I'm sure that's going
to help the most for people to see what's going on here.  Also the
output of 'lspic -vvv' will also be useful.  

Don't expect me to be able to help much, I'm clueless at the low
level.  *grin*

John
