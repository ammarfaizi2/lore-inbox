Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUJWARp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUJWARp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUJWAPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:15:23 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:1331 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269281AbUJWAOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XzbnMAmIiv0YYkuglEBWWyu+a58mwlXrdKY+0WUDC8U4XAUL92BefBLJm8C8NKqRZqX96LyVoIBXXF7mIu4iKuNrwlCKth1enVtdjGLdTbwBdCMQwGEzjfh4WmfuZx71fVq7Pf0IsP8kDi1Maay7KOrDRylUypV/WujYeaXD6lQ=
Message-ID: <35fb2e590410221714205fe526@mail.gmail.com>
Date: Sat, 23 Oct 2004 01:14:01 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Subject: Re: Linux v2.6.9 and GPL Buyout
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <417550FB.8020404@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <417550FB.8020404@drdos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 11:38:03 -0600, Jeff V. Merkey <jmerkey@drdos.com> wrote:

> The memory sickness with disappearing buffers, and the BIO callback
> problems with the SCSI layer previously reported appear to be corrected.

Do you even know anything about the above?

> This release is very solid and withstands 400 MB/S I/O to disk from
> 3GB/1GB split kernel/user memory configurations

Oh good.

> stable enough for us to use and ship in our products based on our
> testing of the 2.6.9 release over two days.

Wow! That's quality there. Do you model your testing process on SCO
directly? i.e. can I have you go on record that your testing process
is satisfied after two days of testing?

> On a side note, the GPL buyout previously offered has been modified. We
> will be contacting individual contributors and negotiating with each copyright holder

Please do keep me aprised of this Jeff. I am quite certain that my
readers will find your anecdotes more than amusing.

> SCO has contacted us and identifed with precise detail and factual
> documentation the code and intellectual property in Linux they claim was
> taken from Unix. We have reviewed their claims and they appear to create enough
> uncertianty to warrant removal of the infringing portions.

Will you offer that as an undertaking, properly signed and sealed,
though? If these unfortunate sections of code are removed, will you
guarantee SCO won't sue?

> We have identified and removed the infringing portions of Linux for our
> products that SCO claims was stolen from Unix.

> and RCU.

But elsewhere you said:

> I have no idea what the hell RCU is

Since this came up in this week's LWN kernel page (you really should
read LWN, it's filled with fascinating content and even features a
special discussion relating to your posting), one simply must ask -
how did you remove code that you do not understand? I really
absolutely want to know how this is possible, because if you have
found a technique for doing this then we can farm off all the really
complex cleanups to MCSE qualified technicians to do instead. This
would save core kernel developers unnecessary hassle and free up their
time to consider your offer in further levels of detail.

> They make claims of other portions of Linux which were taken, however,
> these other claims do not appear to be supported with factual evidence.

Can you guarantee that?

Jon.
