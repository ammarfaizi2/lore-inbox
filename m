Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDJMzW>; Tue, 10 Apr 2001 08:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131806AbRDJMzN>; Tue, 10 Apr 2001 08:55:13 -0400
Received: from ns.suse.de ([213.95.15.193]:6668 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131691AbRDJMzA>;
	Tue, 10 Apr 2001 08:55:00 -0400
Date: Tue, 10 Apr 2001 14:54:53 +0200
From: Andi Kleen <ak@suse.de>
To: Mark Salisbury <mbs@mc.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410145453.A16448@gruyere.muc.suse.de>
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <01041008110318.01893@pc-eng24.mc.com> <20010410144554.A16207@gruyere.muc.suse.de> <0104100846101E.01893@pc-eng24.mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0104100846101E.01893@pc-eng24.mc.com>; from mbs@mc.com on Tue, Apr 10, 2001 at 08:42:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 08:42:33AM -0400, Mark Salisbury wrote:
> On Tue, 10 Apr 2001, Andi Kleen wrote:
> > .... Also generally the kernel has quite a lot of timers. 
> 
> are these generaly of the long interval, failure timeout type?

A lot of them are, but not all.

-Andi
