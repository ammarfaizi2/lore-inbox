Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265963AbUFDUnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265963AbUFDUnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUFDUnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:43:39 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:60130 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265963AbUFDUnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:43:37 -0400
Message-ID: <40C0DEC0.90805@blue-labs.org>
Date: Fri, 04 Jun 2004 16:42:40 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040412
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [boot hang] 2.6.7-rc2, VIA VT8237
References: <40C0D8FE.7040009@blue-labs.org> <200406042238.04100.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200406042238.04100.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

neither of these two options affect the outcome and the only known 
kernel that works on this are the Gentoo 2004.1 LiveCD (2.6.5 gentoo 
built) kernels.  I can't get a vanilla kernel to work on here.  I'm 
trying repeated versions and stripping everything possible out of the 
builds.  So far no luck.

David

Bartlomiej Zolnierkiewicz wrote:

>On Friday 04 of June 2004 22:18, David Ford wrote:
>
>  
>
>>This is a brand new mobo w/ an Opteron 148 on it.  SK8V.  The Gentoo
>>LiveCD is a 2.6.5 kernel and it boots ok on it.  I'm starting to do
>>tests to see what I can do to get it to function.
>>    
>>
>
>Can you try booting with "noapic" and/or "acpi=off"?
>
>If it doesn't work, please do binary search to
>check what is the last working kernel version.
>  
>
