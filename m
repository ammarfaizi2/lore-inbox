Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUG3OHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUG3OHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUG3OHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 10:07:05 -0400
Received: from mail.aei.ca ([206.123.6.14]:22486 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267683AbUG3OG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 10:06:58 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
From: Shane Shrybman <shrybman@aei.ca>
To: mingo@elte.hu
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091196403.2401.10.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 10:06:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Twice while using -L2 my IBM PS2 keyboard has become completely
non-responsive. USB mouse and everything else seems to be fine, but no
LEDs or anything from the keyboard.

On both occasions the last key I hit on the keyboard was numlock and the
numlock did not come on and I had to reboot after that.

UP, x86, gcc 2.95, scsi + ide, bttv

Resolved in M5?

Regards,

Shane

