Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVHOQZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVHOQZS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVHOQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:25:18 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:26645 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964820AbVHOQZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:25:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QP6MlsdXAJcUQc6oDWUnPLVY9Kt66/tsXLJCQf78uGKXr5SwAHubqWX7bqEKsGoAnDOZMNEp2sDAlSZw0RLzp1rgxnfXU6N4W1y0xe/zsn69ixdiQCcTk8ix1GscWnfX0l7lXmII77rt2g7esv6yJkOIEoHidFWvXLNI/Y64PtU=
Message-ID: <4789af9e050815092545fe2925@mail.gmail.com>
Date: Mon, 15 Aug 2005 10:25:14 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
To: yhlu <yhlu.kernel@gmail.com>
Subject: Re: Atyfb questions and issues
Cc: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       alex.kern@gmx.de, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <86802c4405081211021e76349c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e050812101110d3642d@mail.gmail.com>
	 <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
	 <86802c4405081211021e76349c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, yhlu <yhlu.kernel@gmail.com> wrote:
> I played a while with atyfb in LinuxBIOS. move the xl_init.c into LinuxBIOS.
> 
> there is one patch call xlinit.c that can be used even ati fb is not
> inited in BIOS to make kernel still can use atyfb.
> 
> I wonder if James put that in mainstream, he already sent one patch
> for 2.6.5....
> 
> please refer to
> http://www.linuxbios.org/pipermail/linuxbios/2004-May/007734.html

It appears to me that this patch is in the 2.6.11 from linux-mips.org
that I am presently using.

> I guess the mips fw already execute the ati option rom via x86 emulator...

Maybe his mips FW does this, but mine doesn't.  Any tips on how I can
do this in software?

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
