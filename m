Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267605AbSLSLfT>; Thu, 19 Dec 2002 06:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbSLSLfT>; Thu, 19 Dec 2002 06:35:19 -0500
Received: from holomorphy.com ([66.224.33.161]:3777 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267605AbSLSLfS>;
	Thu, 19 Dec 2002 06:35:18 -0500
Date: Thu, 19 Dec 2002 03:42:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] 2.5.52-lsm1
Message-ID: <20021219114246.GN1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20021219025123.A23371@figure1.int.wirex.com> <20021219111433.GM1922@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219111433.GM1922@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 19, 2002 at 02:51:23AM -0800, Chris Wright wrote:
>> The Linux Security Modules project provides a lightweight, general
>> purpose framework for access control.  The LSM interface enables
>> security policies to be developed as loadable kernel modules.
>> See http://lsm.immunix.org for more information.
>> 2.5.52-lsm1 patch released.  This is a rebase up to 2.5.52 as well as
>> numerous module updates and bugfixes.  The interface has changed, and
>> the hooks are controlled with CONFIG_SECURITY now.  Currently LIDS and
>> DTE will not compile.
>> Full lsm-2.5 patch (LSM + all modules) is available at:
>> 	http://lsm.immunix.org/patches/2.5/2.5.52/patch-2.5.52-lsm1.gz
>> The whole ChangeLog for this release is at:
>> 	http://lsm.immunix.org/patches/2.5/2.5.52/ChangeLog-2.5.52-lsm1
>> The LSM 2.5 BK tree can be pulled from:
>>         bk://lsm.bkbits.net/lsm-2.5

On Thu, Dec 19, 2002 at 03:14:33AM -0800, William Lee Irwin III wrote:
> Forgive my ignorance (if this applies) but I recently submitted a patch

My apologies. The patch (as I've heard from hch) has gone out separately.
Thanks to both gregkh and chris for rapid responses, and many apologies
from me wrt. my uninformed responses.

For the majority of -lsm users: This was an API update. No semantic
differences wrt. bugs or other issues should be visible. Thank you
for your patience, and I apologize in advance for my ignorance. Rest
assured in the fact that my changes are not critical to your security
correctness and that chris and gregkh have been thorough, diligent
and highly responsive wrt. the incorporation of this API update along
with your essential security updates.


Thanks,
Bill
