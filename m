Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWGCT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWGCT4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGCT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:56:05 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:55564 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751268AbWGCT4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:56:04 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 20:56:28 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060703030355.420c7155.akpm@osdl.org> <200607032027.21879.s0348365@sms.ed.ac.uk> <20060703123920.ff1a497a.akpm@osdl.org>
In-Reply-To: <20060703123920.ff1a497a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032056.28556.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 20:39, Andrew Morton wrote:
> On Mon, 3 Jul 2006 20:27:21 +0100
>
> Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > On Monday 03 July 2006 11:03, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.
> > >6.17 -mm6/
> >
> > Doesn't boot reliably as an x86-64 kernel on my X2 system, 3/4 times it
> > oopses horribly. Is there some way to supress an oops flood so I can get
> > a decent picture of it with vga=extended? Right now I get two useless
> > oopses after the first (probably useful) one.
>
> Try adding `pause_on_oops=100000' to the kernel boot command line.

(Trimmed Nathan)

Helped somewhat, but I'm still missing a bit at the top.

http://devzero.co.uk/~alistair/oops-20060703/

Apologies for the poor quality photos.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
