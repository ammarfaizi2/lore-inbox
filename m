Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbTDMDiB (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTDMDiB (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:38:01 -0400
Received: from sith.maoz.com ([205.167.76.10]:51618 "EHLO sith.maoz.com")
	by vger.kernel.org with ESMTP id S263139AbTDMDiA (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:38:00 -0400
From: Jeremy Hall <jhall@maoz.com>
Message-Id: <200304130350.h3D3o8pn031108@sith.maoz.com>
Subject: Re: 2.5.67-mm2
In-Reply-To: <20030413031440.GA14357@holomorphy.com> from William Lee Irwin III
 at "Apr 12, 2003 08:14:40 pm"
To: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 12 Apr 2003 23:50:08 -0400 (EDT)
CC: Jeremy Hall <jhall@maoz.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well I guess I could step through one thing at a time, n, because I DO get 
an initial trap it comes as soon as cpus are brought up

but that would take a long time and I'm sure there's LOTS of code.

_J

In the new year, William Lee Irwin III wrote:
> On Sat, Apr 12, 2003 at 11:03:46PM -0400, Jeremy Hall wrote:
> > I dunno about that, but mm2 locks in the boot process and doesn't display 
> > anything to me through gdb even though it is supposed to.  I have gdb 
> > console=gdb but that doesn't make the messages flow.
> 
> An early printk patch (any of the several going around) may give you an
> idea of where it's barfing.
> 
> 
> -- wli
> 

