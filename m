Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132553AbRDUJyJ>; Sat, 21 Apr 2001 05:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDUJx7>; Sat, 21 Apr 2001 05:53:59 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:37249 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S132553AbRDUJxo>;
	Sat, 21 Apr 2001 05:53:44 -0400
Date: Sat, 21 Apr 2001 12:53:29 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: <Wayne.Brown@altec.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
Message-ID: <Pine.LNX.4.30.0104211251340.16271-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001 Wayne.Brown@altec.com wrote:

>
> So how risky is this?

Risky enough. I had to chkdsk once for half an hour after copying on an
NTFS 5. Of course, I'm not familiar with the internals of it.

>
> Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone
> know if FIPS can split a partition safely that was created under Windows
> NT?

As far as I know, it doesn't know about NTFS. I might be wrong though. Get
some Partition Magic that is bit wiser.

