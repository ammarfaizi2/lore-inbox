Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbULNBob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbULNBob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULNBob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:44:31 -0500
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.69]:51510 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261195AbULNBo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:44:27 -0500
Date: Mon, 13 Dec 2004 20:41:11 -0500 (EST)
From: vcjones@NetworkingUnlimited.com (Vincent C Jones)
Subject: Re: Thinkpad T42, keyboard sometimes hosed when waking from sleep
In-reply-to: <3b7Xs-6uL-23@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Message-id: <20041214014111.8DD2E2E4A5@X31.NetworkingUnlimited.com>
Organization: 
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
References: <3b7E7-6ir-21@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3b7Xs-6uL-23@gated-at.bofh.it> you write:
>
>
>On Mon, 13 Dec 2004, Juergen Botz wrote:
>
>> I have a new IBM Thinkpad T42, FC3 with all updates, stock
>> 2.6.9-1.681_FC3 kernel + iwp2200 driver (0.13).  Everyone once
>> in a while when I wake from ACPI S3 sleep my keyboard is hosed...
>> the first key I press starts rapidly auto-repeating, which can't
>> be stopped, and pressing any key produces either no visible
>> action or some other character (not the one normally on that
>> key) which also auto repeats madly.
>>
>> It doesn't always happen, only maybe 10% of the time I come
>> out of S3.  I can't switch to different vt since ctrl-alt-fN
>> don't work, and since I am rarely on a text console I have
>> no idea whether it would happen there.  Putting the machine
>> back to sleep and re-waking doesn't fix it, so my only option
>> has been to reboot via the 'Actions' menu (mouse is ok through
>> all this.)
>>
>> Others have also reported this happening with APM, so it
>> doesn't seem to be an ACPI bug per se.
>>
>> Any ideas?
>
>just another data point. I had seen the same thing happen for me once with 
>my T41p. Same config as above ie FC3, 2.6.9-1.681_FC3.
>
>might be some RH-FC specific thing since I did not see it happen with 
>earlier incarnations of kernel.

Nothing to do with RH-FC-- Same problem started happening here
on a SuSE 9.1 with Xorg X and KDE 3.3+ using APM, not ACPI.
Linux 2.6.9-ac8 on a ThinkPad X31.

--
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
