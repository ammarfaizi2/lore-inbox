Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVKYBeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVKYBeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 20:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVKYBeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 20:34:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48027 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932276AbVKYBeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 20:34:14 -0500
Message-ID: <438669CD.3020004@zytor.com>
Date: Thu, 24 Nov 2005 17:33:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: thockin@hockin.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de> <1132873934.13095.138.camel@localhost.localdomain> <20051124224825.GA20892@hockin.org> <20051124233511.GX20775@brahms.suse.de>
In-Reply-To: <20051124233511.GX20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> IMHO it's time that Linux gets more proactive regarding talking
> to BIOS vendors. Perhaps a generic "BIOS writers guide for Linux"
> would be a good thing.  I have at least one other extension I would like
> BIOS vendors to support. Just would need to come up with a writeup
> for a clearly defined specification.
> 

BIOS, and hardware.  I think Alan wrote something up way long ago, but 
it hasn't really been updated.

	-hpa
