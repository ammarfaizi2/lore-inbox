Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUASM5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 07:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUASM5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 07:57:08 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:34779 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S264604AbUASM5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 07:57:06 -0500
Subject: Re: PROBLEM: ISDN CAPI (avm b1pci) doesn't work, occasionally
	freezes Kernel (2.6.1)
From: fcp <fcp@pop.co.za>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3r7xwqjue.fsf@reason.gnu-hamburg>
References: <200401181746.i0IHkO2G002776@reason.gnu-hamburg>
	 <1074468927.2722.2.camel@server>  <m3r7xwqjue.fsf@reason.gnu-hamburg>
Content-Type: text/plain
Message-Id: <1074531587.1833.5.camel@server>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 14:59:48 -0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 09:05, Georg C. F. Greve wrote:
>  || On Sun, 18 Jan 2004 21:35:27 -0200
>  || fcp <fcp@pop.co.za> wrote: 
> 
>  f> I had similar problems. Running RH9, 2.6.1, W6692 pci card. Spent
>  f> quite some time chasing this and in the end installed mISDN beta
>  f> and it worked the first time. No nonsense. Hope this helps
> 
> Thanks.
> 
> I wonder. If it is a known problem that ISDN doesn't work for multiple
> cards in 2.6.1: Are there plans to incorporate mISDN officially?
> 
> Regards,
> Georg

Don't know but you could ask Fritz at isdn4linux.de.  

He advised me this morning that the latest i4l cvs branch kernel26
version (old isdn system) fixes the problems we are having with the
2.6.1 kernel. Haven't had a chance to test this yet.

