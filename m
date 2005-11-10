Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVKJOKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVKJOKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVKJOKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:10:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:32452 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750946AbVKJOKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:10:19 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 16/21] i386 Eliminate duplicate segment macros
Date: Thu, 10 Nov 2005 15:09:49 +0100
User-Agent: KMail/1.8
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
References: <200511080436.jA84aGvD009933@zach-dev.vmware.com>
In-Reply-To: <200511080436.jA84aGvD009933@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101509.50500.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 November 2005 05:36, Zachary Amsden wrote:
> Get rid of duplicated and ugly segment macros, replacing them
> with slightly less ugly versions in a more appropriate place.

Good stuff. Please submit for x86-64 too.

-Andi
