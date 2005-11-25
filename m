Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbVKXXmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbVKXXmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbVKXXmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:42:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4806 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161073AbVKXXmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:42:15 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: thockin@hockin.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051124233511.GX20775@brahms.suse.de>
References: <1132842847.13095.105.camel@localhost.localdomain>
	 <20051124142200.GH20775@brahms.suse.de>
	 <1132845324.13095.112.camel@localhost.localdomain>
	 <20051124145518.GI20775@brahms.suse.de>
	 <m1psoqgk18.fsf@ebiederm.dsl.xmission.com>
	 <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org>
	 <20051124191445.GR20775@brahms.suse.de>
	 <1132873934.13095.138.camel@localhost.localdomain>
	 <20051124224825.GA20892@hockin.org> <20051124233511.GX20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Nov 2005 00:13:51 +0000
Message-Id: <1132877632.28991.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-25 at 00:35 +0100, Andi Kleen wrote:
> to BIOS vendors. Perhaps a generic "BIOS writers guide for Linux"
> would be a good thing.  I have at least one other extension I would like
> BIOS vendors to support. Just would need to come up with a writeup
> for a clearly defined specification.

I wrote one for 2.2 era but it never got updated. I've probably still
got it around somewhere.

