Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWKFAMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWKFAMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 19:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWKFAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 19:12:35 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:8977 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S932754AbWKFAMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 19:12:34 -0500
Message-ID: <454E7DF1.7020102@superbug.co.uk>
Date: Mon, 06 Nov 2006 00:12:33 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5.0.7 (X11/20061020)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: i387  Floating Point Unit (FPU) testing
References: <454E54B6.5010206@superbug.co.uk> <Pine.LNX.4.61.0611060035080.29462@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0611060035080.29462@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> The kernel contains some i387 FPU emulation code.
>> Is there any user land software to test the FPU emulation code?
>> I would like to be able to prove the correctness of the FPU emulation code in
>> the Linux kernel, and also port the test program to other platforms that
>> utilize FPU emulation. For example, DOS emulators like DOSBOX.
> 
> If the kernel already emulates it, you don't really need emulation in 
> userspace, no?
> 
> 	-`J'

Hum...Did you actually read my email?

