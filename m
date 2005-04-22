Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVDVRvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVDVRvS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVDVRvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:51:18 -0400
Received: from mail3.utc.com ([192.249.46.192]:61178 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262083AbVDVRvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:51:16 -0400
Message-ID: <4269398C.9090305@cybsft.com>
Date: Fri, 22 Apr 2005 12:51:08 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix ultrastor.c compile error
References: <42690274.5040005@cybsft.com> <Pine.LNX.4.58.0504221028050.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504221028050.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 22 Apr 2005, K.R. Foley wrote:
> 
>>This simple patch fixes a compile error in the ultrastor driver. Patch 
>>was originally submitted by Barry K. Nathan as referenced here:
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111391774018717&w=2
>>I just regenerated it against your current git tree. Please apply.
> 
> 
> Can you also verify that it works?

No. I can only verify that it compiles. I don't have the hardware. 
Enabled by default in the config and it hadn't blown up before.

> 
> Finally, when forwarding other peoples patches, please make sure that you 
> include their commentary, and their sign-off. In this case the original 
> definitely has them..

Will do.

> 
> 		Linus
> 


-- 
    kr
