Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUDVGZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUDVGZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 02:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDVGZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 02:25:21 -0400
Received: from terminus.zytor.com ([63.209.29.3]:46534 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262766AbUDVGZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 02:25:19 -0400
Message-ID: <40876544.5000900@zytor.com>
Date: Wed, 21 Apr 2004 23:25:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: manu <manu@prodigylabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: thanx: Re: booting problem ?
References: <4086424B.9070206@prodigylabs.com> <c66hp3$5sv$1@terminus.zytor.com> <4087588C.2010303@prodigylabs.com>
In-Reply-To: <4087588C.2010303@prodigylabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manu wrote:
> 
> thanx for ur reply.
> if u dont mind u want little more information about the problem.
> wht do u mean by legacy floppy drive. if kernel can boot in that why not 
> on IDE floppy drive. i think booting process is done by bios program, i 
> dont think it depends up on kernel.why i cannot install & boot kernel 
> from the compact flash in newer kernels.can u pls give some information 
> about this.
> -manu
> 

You need a bootloader to do it.

	-hpa
