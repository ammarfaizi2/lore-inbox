Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWAFIeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWAFIeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWAFIeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:34:02 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:47070 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751475AbWAFIeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:34:01 -0500
Date: Fri, 6 Jan 2006 00:33:46 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <Pine.LNX.4.61.0601060836020.22809@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0601060032160.1708@qynat.qvtvafvgr.pbz>
References: <E1EuPZg-0008Kw-00@calista.inka.de>
 <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr><Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.61.0601060836020.22809@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Jan Engelhardt wrote:

>> this large boot message issue also slows your boot significantly if you have a
>> fast box that has a serial console, it takes a long time to dump all that info
>> out the serial port.
>
> Don't blame the kernel that serial is slow.

the complaint wasn't that the serial was slow, It was a comment on the 
amount of data being displayed during a boot (which turned out to be in 
large part that I had a verbose config option turned on)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

