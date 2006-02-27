Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWB0Sip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWB0Sip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0Sio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:38:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:43218 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751500AbWB0Sin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:38:43 -0500
Message-ID: <4403472F.2090808@pobox.com>
Date: Mon, 27 Feb 2006 13:38:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <4402934B.7040506@pobox.com> <20060227180433.GA20275@electric-eye.fr.zoreil.com>
In-Reply-To: <20060227180433.GA20275@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>Yep, you missed the data corruption fix (libata) and oops fix (netdev) 
>>that I sent at 5pm EST today...
> 
> 
> Expect a fix for a via-velocity bug when mtu > 1500 and a fix for
> suspend/resume with the 8139cp driver later today.

Cool, I'll send those with the e1000 fix that needs to go.

	Jeff



