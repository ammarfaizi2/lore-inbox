Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCXVB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCXVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVCXVB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:01:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4586 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261347AbVCXVBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:01:38 -0500
Message-ID: <42432A9F.3090507@pobox.com>
Date: Thu, 24 Mar 2005 16:01:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Asfand Yar Qazi <ay1204@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com> <20050324093032.GA14022@havoc.gtf.org> <20050324162706.GJ17865@csclub.uwaterloo.ca>
In-Reply-To: <20050324162706.GJ17865@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> I think the r8139 has ruined realtek for me forever.  I like the Marvell
> Yukon chip Asus includes on many boards (although some people have
> reported problems with some Asus boards using them with Linux).


I won't disagree with your experiences.  For me, outside of one brief 
moment when the r8169 driver didn't work on Athlon64, it has worked 
flawlessly for me.

RealTek 8169 is currently my favorite gigabit chip.

WRT Marvell Yukon, make sure it is not the Yukon2.  Yukon2 isn't 
supported by any driver in the kernel, presently.

	Jeff


