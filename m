Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270519AbTHQTi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTHQTi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:38:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58827 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270519AbTHQTi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:38:58 -0400
Message-ID: <3F3FD9C3.6000601@pobox.com>
Date: Sun, 17 Aug 2003 15:38:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Diehl <lists@mdiehl.de>
CC: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5 IrDA] vlsi driver update
References: <Pine.LNX.4.44.0308172017160.1469-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0308172017160.1469-100000@notebook.home.mdiehl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Diehl wrote:
> On Sun, 17 Aug 2003, Jeff Garzik wrote:
> 
> 
>>Jean Tourrilhes wrote:
>>
>>>ir2603_vlsi-05.diff :
>>>~~~~~~~~~~~~~~~~~~~
>>>		<Patch from Martin Diehl>
>>
>>this patch needs splitting up

> 1) apply single big patch, basically replacing the code
> 2) back out the existing driver and put in a new one resulting in the same 
>    code as above
> 3) do nothing, i.e. stay with vlsi_ir being worse and unsupported in 2.4 
>    forever
> 
> Please advise!

4) split up the patch, pretty please with sugar on it.

	Jeff



