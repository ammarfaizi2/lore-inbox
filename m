Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbRAJV7w>; Wed, 10 Jan 2001 16:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAJV7m>; Wed, 10 Jan 2001 16:59:42 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:4100 "HELO
	smtp.pandora.be") by vger.kernel.org with SMTP id <S130696AbRAJV7f>;
	Wed, 10 Jan 2001 16:59:35 -0500
Date: Wed, 10 Jan 2001 22:53:25 +0100
From: mo6 <sjoos@pandora.be>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Robert Kaiser <rob@sysgo.de>, linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Message-ID: <20010110225325.A9547@pandora.be>
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org> <01010922264400.02737@rob> <20010110205127.B982@pandora.be> <3A5CC3A1.3D8F6BF3@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A5CC3A1.3D8F6BF3@didntduck.org>; from bgerst@didntduck.org on Wed, Jan 10, 2001 at 03:18:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 03:18:41PM -0500, Brian Gerst wrote:
> 
> move up to 2.4.0-testX kernels

I just tested 2.4.0-test1, it doesn't boot on the 386 with the same symptoms 
as 2.4.0.

2.3.99-pre9 same.

2.3.99-pre8 is the last one that boots correctly.

There is one weird thing I notice, the vga-bios-screen at boot-up is
monochrome every other automatic reboot.

with kind regards,

Sven
-- 
If the odds are a million to one against something occurring, chances
are 50-50 it will.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
