Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUEXUZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUEXUZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUEXUYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:24:02 -0400
Received: from [141.156.69.115] ([141.156.69.115]:7857 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264542AbUEXUXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:23:51 -0400
Message-ID: <40B2593C.1050306@infosciences.com>
Date: Mon, 24 May 2004 16:21:16 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <40B24F52.8050805@infosciences.com> <20040524200611.GC4558@kroah.com>
In-Reply-To: <20040524200611.GC4558@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> But this is a different problem from the one you originally set out to
> fix, how about sending a new patch for the treo disconnect problem, and
> then we can work on the next issues.
> 

The more I look at it, the more I agree.  I just wanted to verify that I
didn't break something.


-- 
Joe Nardelli
jnardelli@infosciences.com
