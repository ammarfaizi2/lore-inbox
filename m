Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVLVKeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVLVKeP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLVKeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:34:14 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:64092 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbVLVKeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:34:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c41+PW/zpqeX/HqJl7mbXD5kGoHu/9tXmaRVdCVCynb3Pbx4vELegSo9t5FvmMbEQH2yl6uV2sTcCbuanvgo3pxbFiZvt1lfeWDhcHvkI6dT2qXxSKyRt7EtJb90kzOL1dPm3JRaAblTRDvdQrm8OzPQPM5PGRmtk+WUR6i2w1Y=
Message-ID: <9a8748490512220234i10e39c73pa7f4de0a505ff28d@mail.gmail.com>
Date: Thu, 22 Dec 2005 11:34:13 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: kernel coder <lhrkernelcoder@gmail.com>
Subject: Re: IDE subsytem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f69849430512220151n641cef60x686e665bddc2ddf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f69849430512220151n641cef60x686e665bddc2ddf7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/05, kernel coder <lhrkernelcoder@gmail.com> wrote:

Hmm, why "kernel coder" and not your real name?  It's nice to know who
you're communicating with, no need to hide behind an alias.

> hi,
>
>    I was trying to figure out the control flow in IDE subsystem.I
> googled but could not get information.
> Please refer me some document about about linux IDE susbsytem
>
There are docs in the tree. Check Documentation/ide.txt ,
Documentation/ioctl/hdio.txt and the various documents in
Documentation/block/ for starters.
There's also the code itself.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
