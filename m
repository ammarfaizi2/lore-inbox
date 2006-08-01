Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWHAT7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWHAT7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWHAT7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:59:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750775AbWHAT7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:59:23 -0400
Date: Tue, 1 Aug 2006 15:59:18 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: wire up missing syscalls on x86-64
Message-ID: <20060801195918.GZ22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801185738.GT22240@redhat.com> <200608012155.34431.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608012155.34431.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:55:34PM +0200, Andi Kleen wrote:
 > On Tuesday 01 August 2006 20:57, Dave Jones wrote:
 > > Signed-off-by: Dave Jones <davej@redhat.com>
 > 
 > No, the reason they're not wired up yet is that some infrastructure
 > for them is still missing. It's currently queued up for .19

Ah, I missed the fact that we're also carrying another diff
in the Fedora kernel for this.  Ok, as long as you're aware
of it, all is good.

		Dave

-- 
http://www.codemonkey.org.uk
