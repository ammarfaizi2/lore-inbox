Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUC0KB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 05:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0KB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 05:01:57 -0500
Received: from main.gmane.org ([80.91.224.249]:30152 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261638AbUC0KB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 05:01:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: USB broken in 2.6.5rc2
Date: Sat, 27 Mar 2004 05:01:53 -0500
Message-ID: <40655111.4010806@aripollak.com>
References: <40654681.5070806@p3EE060FB.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cygnus.ccs.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <40654681.5070806@p3EE060FB.dip0.t-ipconnect.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a thread about this on the usb-devel mailing list. Basically a 
lot of devices don't work properly anymore in -rc1 or -rc2. There's a 
non-final workaround patch here:
http://thread.gmane.org/gmane.linux.kernel/190829

Andreas Hartmann wrote:
> My only chance to get it working again is a reboot.
> 
> This problem does not happen, if the device isn't mounted. Will say: If 
> you just plug it in and plug it out again, the device is recognized 
> again when plugged in again.
> 
> 
> Kind regards,
> Andreas Hartmann

