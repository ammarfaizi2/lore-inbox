Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVAUMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVAUMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVAUMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:32:56 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:13531 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262349AbVAUMcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:32:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: hugang@soulinfo.com
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Fri, 21 Jan 2005 13:32:53 +0100
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <200501202246.38506.rjw@sisk.pl> <20050121022348.GA18166@hugang.soulinfo.com>
In-Reply-To: <20050121022348.GA18166@hugang.soulinfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211332.53761.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 21 of January 2005 03:23, hugang@soulinfo.com wrote:
> On Thu, Jan 20, 2005 at 10:46:37PM +0100, Rafael J. Wysocki wrote:
> > On Thursday, 20 of January 2005 21:59, Pavel Machek wrote:
> > 
> > Sure, but I think it's there for a reason.
> > 
> > > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> > 
> > I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> > If necessary, I can change the patch to work with his code (hugang, what do you think?).
> > 
> I like this patch, And I change my code with this, Please have a look,
> It pass in qemu X86_64. :)

Looks good.  I'll test it later today.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
