Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285000AbRLFF5c>; Thu, 6 Dec 2001 00:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284826AbRLFF5W>; Thu, 6 Dec 2001 00:57:22 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:60178 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S283938AbRLFF5H>; Thu, 6 Dec 2001 00:57:07 -0500
Date: Fri, 30 Nov 2001 22:04:29 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] vanilla 2.4.15 iptables/REDIRECT kernel oops
Message-Id: <20011130220429.18d5303d.rusty@rustcorp.com.au>
In-Reply-To: <200111271143.MAA11403@linux06.vertis.nl>
In-Reply-To: <200111271143.MAA11403@linux06.vertis.nl>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001 12:43:09 +0100
Rolf Fokkens <fokkensr@linux06.vertis.nl> wrote:

> I got another kernel oops related to iptables/REDIRECT, this time it's a plain vanilla kernel 2.4.15

Hi Rolf!

	This bug does not exist in the final 2.4.15: it was my mistake in
the pre- kernels, and was removed for 2.4.15.  Please check again.

Hope that helps,
Rusty.

