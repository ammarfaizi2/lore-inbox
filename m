Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbTC0Nhd>; Thu, 27 Mar 2003 08:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbTC0Nhd>; Thu, 27 Mar 2003 08:37:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15745 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262930AbTC0Nha>;
	Thu, 27 Mar 2003 08:37:30 -0500
Message-ID: <3E830152.6020200@pobox.com>
Date: Thu, 27 Mar 2003 08:49:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre6
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva> <20030327075357.GB3829@k3.hellgate.ch>
In-Reply-To: <20030327075357.GB3829@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Wed, 26 Mar 2003 21:08:42 -0300, Marcelo Tosatti wrote:
> 
>>We are approaching -rc stage. I plan to release -pre7 shortly which should
>>fixup the remaining IDE problems (thanks Alan!) and -rc1 later on.
> 
> 
> via-rhine is still at 1.16 -- broken for the most common Rhine model. I
> thought 1.17 was supposed to go into 2.4.21?


I need to revert pcnet32 to back to 2.4.19 level, and then my batch is 
ready for Marcelo -- which includes your via-rhine fixes.

	Jeff



