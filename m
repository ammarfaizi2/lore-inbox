Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTAZVXR>; Sun, 26 Jan 2003 16:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbTAZVXR>; Sun, 26 Jan 2003 16:23:17 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7690 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266994AbTAZVXQ>; Sun, 26 Jan 2003 16:23:16 -0500
Date: Sun, 26 Jan 2003 13:27:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Bryan Andersen <bryan@bogonomicon.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
In-Reply-To: <3E33C55A.5050403@bogonomicon.net>
Message-ID: <Pine.LNX.4.10.10301260727570.1744-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bryan,

The one nobody has written in closed form as of to date.
Basically it is a DNE (does not exist).

The infrastructure is just now being laid into place now so, it will take
some time to code out the rest of the internals to allow standard UI
access.

I have my own suite of "private" tools, and they will not be released.
There are possible patent issues, and licensing problems.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 26 Jan 2003, Bryan Andersen wrote:

> 
> 
> Andre Hedrick wrote:
> > Yeah "smartctl" does not work, but reading the correct 48-bit logs does.
> > 
> > All I stated was you are using the wrong tool to extract the needed
> > information.
> 
> So which tool(s) do I need for getting at the 48-bit log data?  If I 
> need a spec doc to decode a binary block of data I can deal with that. 
> Prefer not to, but...
> 
> I did a full surface read scan of the disk and it turned up no errors.
> 
> As for how I got the SMART data dump I enabled SMART on the drive then 
> dumped the data a few minutes later.
> 
> - Bryan
> 


