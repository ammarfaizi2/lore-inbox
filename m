Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278189AbRJSDtD>; Thu, 18 Oct 2001 23:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278285AbRJSDsy>; Thu, 18 Oct 2001 23:48:54 -0400
Received: from mail.wave.co.nz ([203.96.216.11]:56376 "EHLO mail.wave.co.nz")
	by vger.kernel.org with ESMTP id <S278189AbRJSDsr>;
	Thu, 18 Oct 2001 23:48:47 -0400
Date: Fri, 19 Oct 2001 16:49:16 +1300
From: Mark van Walraven <markv@wave.co.nz>
To: hanhbkernel <hanhbkernel@yahoo.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd problem of 2.4.10
Message-ID: <20011019164916.C596@mail.wave.co.nz>
Mail-Followup-To: hanhbkernel <hanhbkernel@yahoo.com.cn>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011019141926.B596@mail.wave.co.nz> <20011019033955.43057.qmail@web15005.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20011019033955.43057.qmail@web15005.mail.bjs.yahoo.com>; from hanhbkernel on Fri, Oct 19, 2001 at 11:39:55AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 11:39:55AM +0800, hanhbkernel wrote:
> thanks for your help but I have checked /lib/ld-* in
> the initrd.the permission is right.please give me more
> help 

What command line arguments do you pass to linux, and in what order?

I presume your initrd has /bin/sh?  What happens if boot with init=/bin/sh?

Mark.
