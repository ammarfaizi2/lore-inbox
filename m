Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266804AbSKUQRG>; Thu, 21 Nov 2002 11:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbSKUQRG>; Thu, 21 Nov 2002 11:17:06 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:18640 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266804AbSKUQRE>; Thu, 21 Nov 2002 11:17:04 -0500
Message-ID: <3DDD089F.5080609@nortelnetworks.com>
Date: Thu, 21 Nov 2002 11:23:59 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Felix Seeger <felix.seeger@gmx.de>
Cc: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org, Nero <neroz@iinet.net.au>
Subject: Re: 2.5.48 QM_MODULES: Function not implemented
References: <200211202004.20261.felix.seeger@gmx.de> <3DDBF02D.4060005@iinet.net.au> <3DDC0AC8.9070308@nortelnetworks.com> <200211210042.17225.felix.seeger@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Seeger wrote:

> Maybe it is normal but this doesn't fix the depmod problem even with the new 
> kernel, I have modprobe, rmod and so back but the package doesn't include 
> depmod.

Yep.  Tnere is no depmod.  Bang on Rusty to fix things.

> I am running debian unstable, many install scripts uses parameters that are 
> not provided by this version (I think -l and -r).
> Maybe this is only for debian so I have to wait for a patched package...

Rusty didn't include them.

> Is it a bug that all modules are in the same dir without subdirs ? It is hard 
> to find them.

See Rusty.


There is a certain trend here....not that modules didn't need fixing, 
but this is pretty serious functionality breakage.


Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

