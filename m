Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUGELGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUGELGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUGELGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:06:22 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:37553 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266013AbUGELGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:06:20 -0400
Message-ID: <297f4e01040705040614362b9@mail.gmail.com>
Date: Mon, 5 Jul 2004 13:06:06 +0200
From: Ikke <ikke.lkml@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: 4K vs 8K stacks- Which to use?
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       ap@solarrain.com
In-Reply-To: <20040704123431.GA23204@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.60.0407030649120.13543@p500> <297f4e0104070403553efe6821@mail.gmail.com> <20040704123431.GA23204@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will when I get my next kernel (compiling one takes some time here).

On Sun, 4 Jul 2004 05:34:31 -0700, Chris Wedgwood <cw@f00f.org> wrote:
> On Sun, Jul 04, 2004 at 12:55:07PM +0200, Ikke wrote:
> 
> > I got a P2 here, and got some problems that *could* be
> > related to 4k stacks.  I'm running 2.6.7-redeeman3 now
> > (i.e. 2.6.7-mm3+reiser4+nick's sheduler).  If I configure
> > it using 4k stacks and APM as module (not loaded) I get
> > crashes (Page Faults I think). Same configuration, but 4k
> > stacks disabled and APM module disabled, runs stable.
> 
> Try turning on the stack overflow checking and see what that
> spits out.
> 
> 
>   --cw
>
