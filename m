Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSLEATa>; Wed, 4 Dec 2002 19:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbSLEATa>; Wed, 4 Dec 2002 19:19:30 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:57774 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267022AbSLEAT3>; Wed, 4 Dec 2002 19:19:29 -0500
Message-ID: <3DEE9D53.10908@cora.nwra.com>
Date: Wed, 04 Dec 2002 17:26:59 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Flory <sflory@rackable.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS - IRIX client issues
References: <3DEE85D3.6070009@cora.nwra.com> <3DEE8EC2.2040305@rackable.com> <3DEE9425.40204@cora.nwra.com> <3DEE95D0.9010706@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:

> Orion Poplawski wrote:
>
>> The mount is automounted,  the resulting mtab entry on IRIX is:
>
>
>
>  Are you using amd or autofs?  Does it occur when you manually mount 
> the share? "mount lego:/export/turb3 /data/turb3"


autofs.  Do you realy think there is a difference between using mount 
and autofs to establish the mount?

>>
>> I'll look into trying nolock and v2.  SHould I try TCP?
>

Hm.  IRIX doesn't seem to have a nolock option.

