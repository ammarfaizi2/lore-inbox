Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161808AbWKIGDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161808AbWKIGDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161809AbWKIGDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:03:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:3250 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161808AbWKIGDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:03:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YYzzAwdws4R/RhZp85dPYYcVviIKy0VOB79oSruEMPMM+Ng/9MJqsNL7fTBFrdHEkrGAaAYK/p4a2R6LNqVy7nSXlA4rWPBsYP1wzy3RM7WaJr0lAH5SVpHwNMARrNcMXc0kgpJ6m0mc3v+tiQxxTh1NRpCcuShidfZLnApK9Rk=
Message-ID: <2ea3fae10611082203s68454772l8970d180008dc246@mail.gmail.com>
Date: Wed, 8 Nov 2006 22:03:17 -0800
From: yhlu <yinghailu@gmail.com>
To: Horms <horms@verge.net.au>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Cc: "Fastboot mailing list" <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061109054805.GA28415@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
	 <20061109054805.GA28415@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19 AMD64
1. kexec 2.6.17 AMD64 bzImage ? elf32 ( made by mkelfImage 2.5)
2. kexec suse 10.0 amd64 vmlinuz and initrd.

YH

On 11/8/06, Horms <horms@verge.net.au> wrote:
> On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> > Eric,
> >
> > I got "Invalid memory segment 0x100000 - ..."
> > using kexec latest kernel...
>
> Which kernel? What config? What architecture? What hardware?
>
> > Do I need patch for kexec tools with latest kexec in kernel?
>
> Its largely dependant on what architecture you are using.
> But try out kexec-tools-testing if you are not already doing so.
> It is available via git from www.kernel.org/git
>
> --
> Horms
>   H: http://www.vergenet.net/~horms/
>   W: http://www.valinux.co.jp/en/
>
> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/fastboot
>
