Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbSKSWDo>; Tue, 19 Nov 2002 17:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbSKSWDo>; Tue, 19 Nov 2002 17:03:44 -0500
Received: from holomorphy.com ([66.224.33.161]:57830 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267424AbSKSWDl>;
	Tue, 19 Nov 2002 17:03:41 -0500
Date: Tue, 19 Nov 2002 14:07:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Richards <drichard@largo.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: Off List Message - Kernel Problem - Respond To Me
Message-ID: <20021119220751.GX11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Richards <drichard@largo.com>, linux-kernel@vger.kernel.org,
	manfred@colorfullife.com
References: <1037742240.31569.9.camel@oa3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037742240.31569.9.camel@oa3>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 04:44:00PM -0500, Dave Richards wrote:
> Nov 19 14:09:41 desktop_a kernel: ldt allocation failed
> We get this error over and over again and no additional users can log
> into the server.
> I'm not on the linux-kernel list, but if anyone has insight into this
> issue, please drop me a line.  If you know a way to fix this in the 2.4
> kernel too, or can verify that we have to wait for 2.5/2.6 we need to
> know that too.

IIRC this has been hit in threaded benchmarks before; ISTR a fix for LDT
OOM going around, probably manfred's stuff which is in 2.5 and 2.4-ac.


Thanks,
Bill
