Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWGFTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWGFTP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGFTP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:15:58 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:53255 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750724AbWGFTP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:15:57 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.17-mm6
Date: Thu, 6 Jul 2006 20:16:22 +0100
User-Agent: KMail/1.9.3
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <1152207073.24656.127.camel@cog.beaverton.ibm.com> <200607062006.38816.s0348365@sms.ed.ac.uk>
In-Reply-To: <200607062006.38816.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607062016.22311.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 July 2006 20:06, Alistair John Strachan wrote:
> I'm about to try a kernel without the lockdep stuff, then I'm going to
> start bisection pain.

And it doesn't make any difference; it really does look like a bug in 
something else.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
