Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267198AbUHIU4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUHIU4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUHIU4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:56:17 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:59608 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S267198AbUHIUj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:39:28 -0400
Date: Mon, 9 Aug 2004 13:39:20 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tupshin Harper <tupshin@tupshin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev/hdl not showing up because of fix-ide-probe-double-detection
 patch
In-Reply-To: <1092078372.14640.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0408091335450.5662@twin.uoregon.edu>
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com> 
 <20040804224709.3c9be248.akpm@osdl.org>  <1091720165.8041.4.camel@localhost.localdomain>
  <4117C028.7080905@tupshin.com> <1092078372.14640.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004, Alan Cox wrote:

> On Llu, 2004-08-09 at 19:19, Tupshin Harper wrote:
>> Doing a google search on "M0000000000000000000" shows that there have a
>> been a handful of reports of maxtor drives showing this as the serial
>> number, but I don't see any explanation of why.
>
> Thanks. Well thats easy to special case. Wonder what kind of a cow the
> Maxtor was having that day 8)
>
> M00 indeed

that's a big field... if maxtor manages to ship 10^18 disks we're not 
going to have room on the surface of the earth for them all... ;)

> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

