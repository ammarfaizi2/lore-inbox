Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTBCH4o>; Mon, 3 Feb 2003 02:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTBCH4o>; Mon, 3 Feb 2003 02:56:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266095AbTBCH4n>;
	Mon, 3 Feb 2003 02:56:43 -0500
Message-ID: <3E3E22DC.60806@pobox.com>
Date: Mon, 03 Feb 2003 03:05:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: a code slush for 2.5?
References: <3E3E21D3.1090402@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> to be made, before a lot of that can be used, too.  Power Management is 
> another area.  That sorta fell by the wayside, IMO, but _is_ doable 
> given the current infrastructure that 2.5 now has.


To clarify a bit, _CPU_ power management is looking quite nice, I was 
referring mainly to PCI bus power management, and other host/bus PM issues

