Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWHAT4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWHAT4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWHAT4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:56:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62922 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWHAT4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:56:39 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: wire up missing syscalls on x86-64
Date: Tue, 1 Aug 2006 21:55:34 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801185738.GT22240@redhat.com>
In-Reply-To: <20060801185738.GT22240@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608012155.34431.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 August 2006 20:57, Dave Jones wrote:
> Signed-off-by: Dave Jones <davej@redhat.com>

No, the reason they're not wired up yet is that some infrastructure
for them is still missing. It's currently queued up for .19

-Andi

