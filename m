Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWJBKDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWJBKDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWJBKDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:03:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:49857 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750703AbWJBKDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:03:10 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Please report all left over "DWARF2 unwinder stucks"
Date: Mon, 2 Oct 2006 12:03:05 +0200
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <200610012201.20544.ak@suse.de> <20061001211435.GC26348@redhat.com>
In-Reply-To: <20061001211435.GC26348@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021203.05590.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 23:14, Dave Jones wrote:
> On Sun, Oct 01, 2006 at 10:01:20PM +0200, Andi Kleen wrote:
>  > 
>  > All the fixes for known "DWARF2 unwinder stuck at ..." are
>  > in Linus -git mainline now.
>  > 
>  > If you still see any with current -git please report them.
> 
> I'm doing a 2.6.18 update for Fedora users soon, so I'll try
> and scoop up all these and backport them.  If any pop out of
> the woodwork after that, I'll let you know.

That's a lot of patches. But ok your call.

-Andi
