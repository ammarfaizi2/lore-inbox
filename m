Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbSIVE4c>; Sun, 22 Sep 2002 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276278AbSIVE4c>; Sun, 22 Sep 2002 00:56:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S276249AbSIVE4b>;
	Sun, 22 Sep 2002 00:56:31 -0400
Message-ID: <3D8D4E94.8030707@mandrakesoft.com>
Date: Sun, 22 Sep 2002 01:01:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] IDE probe & waiting for busy
References: <Pine.LNX.4.10.10209212150410.25090-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Ben,
> 
> Catch Jeff and see if the execute diagnostics will solve the problem and
> if so we can extend the state machine path to cover the Apple mess.
> 
> Thoughts?



> On Sat, 21 Sep 2002, Benjamin Herrenschmidt wrote:
>>If you prefer still running the execute diagnostics command for
>>probe, then feel free to implement it ;)



Ben, in fact I implemented it.  :)  I have been meaning to merge it into 
the 2.4-ac stuff Alan/Andre are doing.

	Jeff



