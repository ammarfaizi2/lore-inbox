Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318546AbSHEP2Y>; Mon, 5 Aug 2002 11:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSHEP2Y>; Mon, 5 Aug 2002 11:28:24 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:38124 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318546AbSHEP2Y>; Mon, 5 Aug 2002 11:28:24 -0400
Message-ID: <3D4E9B82.30303@snapgear.com>
Date: Tue, 06 Aug 2002 01:36:34 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
References: <3D4AACDA.2010902@snapgear.com>  <3D4A27FE.8030801@snapgear.com> <3007.1028299196@redhat.com> <29284.1028541729@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Woodhouse wrote:
> gerg@snapgear.com said:
> 
>> Did you have a look at uclinux.c, that is the one I was referring to
>>here?
> 
> 
> I remember it being there, don't remember objecting to anything in it ;)

Must be alright then :-)
It is pretty simple, almost trivial.

I am just about to put up a new patch set that removes all the
MAGIC_ROM_POINTER stuff from the MTD code (amongst many other clean
ups). The MTD patches within it are pretty clean now.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

