Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263451AbVCEAgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbVCEAgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbVCEAMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:12:39 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:41443 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S263147AbVCDXfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:35:07 -0500
Message-ID: <4228F087.70504@am.sony.com>
Date: Fri, 04 Mar 2005 15:34:31 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302235206.GK3163@waste.org>
In-Reply-To: <20050302235206.GK3163@waste.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> One last plea for the 2.4 scheme:
> 
> I think naming the interim releases -pre/-rc has done this admirably
> for 2.4.

I agree.  This makes more sense to me than some implicit understanding
about the parity of the revision.

rc is easy to understand, and '-pre' is easy to understand
once you recognize it means 'beta'.

I've been bothered in the 2.6 series that rc ("release candidate"?)
tags were applied to kernels that were clearly NOT release candidates.


=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
