Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTEAXUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTEAXT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:19:59 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:5331
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262788AbTEAXT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:19:58 -0400
Message-ID: <3EB1AE73.8070408@infidigm.net>
Date: Thu, 01 May 2003 19:32:03 -0400
From: Jeff Muizelaar <kernel@infidigm.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface.
References: <20030501194702.GA2997@ranty.ddts.net> <20030501201943.GA3498@kroah.com>
In-Reply-To: <20030501201943.GA3498@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 19:32:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>As all devices in the kernel should now be in sysfs (if not, please let
>me know what busses haven't been converted yet), 
>
How about plain old isa?

-Jeff

