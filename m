Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSHPVAP>; Fri, 16 Aug 2002 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHPVAP>; Fri, 16 Aug 2002 17:00:15 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:38899 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317693AbSHPVAO>; Fri, 16 Aug 2002 17:00:14 -0400
Message-ID: <3D5D68C4.8030806@us.ibm.com>
Date: Fri, 16 Aug 2002 14:04:04 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] add buddyinfo /proc entry
References: <Pine.LNX.4.44.0208161158270.1048-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> You're making things up and spreading FUD. Why would you want to do that? 

Because IBM has a grand, secret plan to replace driverfs with 
BigBlueFS.  We have brainwashed Linus into taking it and we will rule 
the world!

No, I'm just being selfish and I'm a bit uninformed.  I understand it 
better now because Greg explained why you want to do it.  The thing 
that did it for me was Linus's decree that vm tunables _will_ move to 
driverfs.  That changes the scenario from "Greg and Patrick are 
bitching" to "Linus wants this" and thus it will be the wave of the 
future.   Maybe you guys need to make this a bit more clear.

> Oh right, it's because most "kernel developers" would rather bitch about 
> that which they do not understand and cut down other developers than suck 
> it up and actually try to learn something from someone else. 

I'm trying to understand, that's why I asked so many questions.  I am 
mistaken about the machine not booting completely if it doesn't 
understand a fs-type, Greg corrected me here.

Summary:
A driverfs version of this patch is on the way.
-- 
Dave Hansen
haveblue@us.ibm.com

