Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968282AbWLEPRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968282AbWLEPRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968284AbWLEPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:17:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50391 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968282AbWLEPRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:17:52 -0500
Message-ID: <45758CB3.80701@redhat.com>
Date: Tue, 05 Dec 2006 10:13:55 -0500
From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165308400.2756.2.camel@localhost>
In-Reply-To: <1165308400.2756.2.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
> Hi Kristian,
> 
>> I'm announcing an alternative firewire stack that I've been working on
>> the last few weeks.  I'm aiming to implement feature parity with the
...
> can you please use drivers/firewire/ if you want to start clean or
> aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> the directory path is not really helpful.

Yes, that's probably a better idea.  Do you see a problem with using fw_* as a 
prefix in the code though?  I don't see anybody using that prefix, but Stefan 
pointed out to me that it's often used to abbreviate firmware too.

Kristian

