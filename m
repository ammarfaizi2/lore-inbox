Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUCXGZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 01:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbUCXGZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 01:25:50 -0500
Received: from colin2.muc.de ([193.149.48.15]:30474 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263024AbUCXGZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 01:25:49 -0500
Date: 24 Mar 2004 07:25:48 +0100
Date: Wed, 24 Mar 2004 07:25:48 +0100
From: Andi Kleen <ak@muc.de>
To: George Anzinger <george@mvista.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Call frame debug info for 2.6 kernel
Message-ID: <20040324062548.GA96115@colin2.muc.de>
References: <1AR5s-75I-27@gated-at.bofh.it> <1CHY0-1Uw-9@gated-at.bofh.it> <m3n0685nfp.fsf@averell.firstfloor.org> <4060B005.4020804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4060B005.4020804@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The long and short of it is, to do it at all, you need to have a fair 
> knowledge of dwarf2.  Once you get to that, I suspect one way is as good as 
> another.

Did you contact the gdb and binutils maintainers about the problems?
Maybe it can be easily fixed.

-Andi
