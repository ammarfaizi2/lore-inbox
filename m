Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTAZLQi>; Sun, 26 Jan 2003 06:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTAZLQi>; Sun, 26 Jan 2003 06:16:38 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:47300 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S266810AbTAZLQh>; Sun, 26 Jan 2003 06:16:37 -0500
Message-ID: <3E33C55A.5050403@bogonomicon.net>
Date: Sun, 26 Jan 2003 05:24:10 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Manish Lachwani <manish@Zambeel.com>,
       Manish Lachwani <m_lachwani@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
References: <Pine.LNX.4.10.10301260125510.1744-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andre Hedrick wrote:
> Yeah "smartctl" does not work, but reading the correct 48-bit logs does.
> 
> All I stated was you are using the wrong tool to extract the needed
> information.

So which tool(s) do I need for getting at the 48-bit log data?  If I 
need a spec doc to decode a binary block of data I can deal with that. 
Prefer not to, but...

I did a full surface read scan of the disk and it turned up no errors.

As for how I got the SMART data dump I enabled SMART on the drive then 
dumped the data a few minutes later.

- Bryan

