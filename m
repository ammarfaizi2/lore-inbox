Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVCDC1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVCDC1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVCDCZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:25:11 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:43213 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262009AbVCDCTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:19:24 -0500
Message-ID: <4227C62B.30504@jp.fujitsu.com>
Date: Fri, 04 Mar 2005 11:21:31 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com> <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org> <20050301165904.GN28741@parcelfarce.linux.theplanet.co.uk> <422524B1.10405@jp.fujitsu.com> <20050302174438.GH1220@austin.ibm.com>
In-Reply-To: <20050302174438.GH1220@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> Below is some "pseudocode" version (mentally substitute 
> "pci error event" for every occurance of "eeh").  Its got some
> ppc64-specific crud in there that we have to fix to make it 
> truly generic (I just cut and pasted from current code).
> 
> Would a cleaned up version of this code be suitable for a 
> arch-generic pci error recovery framework?  Seto, would 
> this be useful to you?

Yes, it would. I'm looking forward to see your generic one.

Thanks,
H.Seto

