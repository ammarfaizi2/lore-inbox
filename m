Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318852AbSHETN0>; Mon, 5 Aug 2002 15:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318853AbSHETN0>; Mon, 5 Aug 2002 15:13:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57611 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318852AbSHETNZ>;
	Mon, 5 Aug 2002 15:13:25 -0400
Message-ID: <3D4ECF2B.2070000@mandrakesoft.com>
Date: Mon, 05 Aug 2002 15:16:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Abraham vd Merwe <abraham@2d3d.co.za>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
References: <200208051906.g75J6d122986@www.hockin.org>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
>>>Is there a document describing the ethtool ioctl's which need to be
>>>implemented in each ethernet driver?
>>
>>
>>Unfortunately not.  There is a distinct lack of network driver docs at 
>>the moment...  The best documentation is looking at source code of 
>>drivers that implement the most ioctls.
> 
> 
> 
> I've got a draft of a quick overview doc.  I need to add docs for a few of
> the newer commands, still, and I want to get into the structs for each call
> in more detail, too.  I want to re-examine a few of recent additions,
> before they become too ubiquitous - am I too late to pipe up for my own
> aesthetics?


Sure, comments are always welcome.

And if you're bored, IMO putting the docs into Documentation/DocBook is 
preferred :)

