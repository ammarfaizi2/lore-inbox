Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbWKPHFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWKPHFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 02:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWKPHFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 02:05:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:46053 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422634AbWKPHFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 02:05:36 -0500
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Date: Thu, 16 Nov 2006 08:05:32 +0100
User-Agent: KMail/1.9.5
Cc: Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <455BBF38.5030503@vmware.com> <20061116022753.GC6602@sequoia.sous-sol.org>
In-Reply-To: <20061116022753.GC6602@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160805.32539.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 03:27, Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
> > Well that shouldn't have happened.  Must have been some reject that went 
> > unnoticed?  Try this.
> 
> Thanks Zach, added to the pv patchqueue as well.

That was one of the things that got fixed in paravirt-compile too iirc

-Andi
