Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWAOTRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWAOTRy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWAOTRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:17:54 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:58567 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750800AbWAOTRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:17:53 -0500
Message-ID: <43CA9FC7.9000802@cfl.rr.com>
Date: Sun, 15 Jan 2006 14:17:27 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Damian Pietras <daper@daper.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com> <20060115185025.GA15782@daper.net>
In-Reply-To: <20060115185025.GA15782@daper.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Pietras wrote:
> On Sun, Jan 15, 2006 at 12:53:25PM -0500, Phillip Susi wrote:
> 
> Neither Ubuntu kernel nor this patch fixes the problem.
> 
> 

You might want to try it under dapper then.  If you still have that 
problem, then it's got to be busted hardware.  You might try updating 
the firmware in the drive.

> 
> This is just updated udftools package? I don't think it's a userspace
> problem. It happens also for CD-Rs with iso9660 filesystem.
> 

Right, I just mentioned that because there are a number of fixes that 
are required to make udftools actually 'usable' which you might be 
interested in.  I also need beta testers :)

