Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312410AbSCYMV0>; Mon, 25 Mar 2002 07:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSCYMVQ>; Mon, 25 Mar 2002 07:21:16 -0500
Received: from catv7012.extern.kun.nl ([131.174.117.12]:28301 "EHLO
	luna.ellen.dexterslabs.com") by vger.kernel.org with ESMTP
	id <S312410AbSCYMVI>; Mon, 25 Mar 2002 07:21:08 -0500
Date: Mon, 25 Mar 2002 13:21:02 +0100 (CET)
From: <danny@mailmij.org>
To: <cooker@linux-mandrake.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Cooker] (RFC) Supermount 2
In-Reply-To: <001d01c1d3ec$2e914720$b0d3fea9@pcs686>
Message-ID: <Pine.LNX.4.33.0203251316560.26580-100000@luna.ellen.dexterslabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Mar 2002, Matthew D. Pitts wrote:
> 
> I am starting to plan a new version of Supermount. I have some things I want to try out in it, and I will list them in this message. I am willing to accept any and all input on what I am wanting to call Supermount 2.
> Planned features of Supermount 2:
> 
> 1) Auto-detection of filesystem type. 
Meaning we will finally have CD-tracks visualized as WAV files? like CD-fs 
does? Same goes for multisession disks.
> 
> 2) Supermount modules for each filesystem type.
How is this on performance (first check for fs type than loading module? 
than disk is removed, unloading module and loading another one?)

> 
> 3) Built-in support for packet-writing. ( i.e. insert packet-writing formatted disk and it loads appropriate kernel modules. )
> 
> There may be other features added if there is an interest in them. I will need assistance with the packet-writing support. I am only planning to do this for the 2.5.x and later kernels, so if anyone else wishes to back-port it to an older kerenl series, by all means do so. I have wanted to make some kind of contribution to this project for some time and I feel that this is something that will be useful.
> 
What about doing it in userspace? I remember seeing Alan Cox writing he 
had a proof of concept of something like this on some ftp server (sorry, 
cannot remember where).


> I am going to be making my prelminary code available to whomever wishes to see it once I get my Linux box back up.
sure



Danny

> 
> Matthew D. Pitts
> 

