Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVCMDNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVCMDNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVCMDNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:13:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3026 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262587AbVCMDNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:13:53 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: AGP bogosities
Date: Sat, 12 Mar 2005 19:13:05 -0800
User-Agent: KMail/1.7.2
Cc: Mike Werner <werner@sgi.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <200503111927.04807.werner@sgi.com> <20050312035809.GB8654@redhat.com>
In-Reply-To: <20050312035809.GB8654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503121913.05660.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 7:58 pm, Dave Jones wrote:
>  > sgi-agp.c was sent to Dave about 2 weeks ago. I assumed he was waiting
>  > for the TIO header files to make it from the ia64 tree into Linus's
>  > tree.
>
> Actually I just got swamped with other stuff, and dropped the ball.
> I still have the patch in my queue though, so I can push that along.
>
> Are those headers in mainline yet ?

Yeah, I think it's all there now.  Looks like Linus did a pull from ia64 
recently, so it *should* all build.

Thanks,
Jesse
