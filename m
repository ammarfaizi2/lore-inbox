Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282074AbRLNJVc>; Fri, 14 Dec 2001 04:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282379AbRLNJVW>; Fri, 14 Dec 2001 04:21:22 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39185
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282074AbRLNJVO>; Fri, 14 Dec 2001 04:21:14 -0500
Date: Fri, 14 Dec 2001 01:15:48 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] DRM OS 
In-Reply-To: <Pine.LNX.4.10.10112121959320.8479-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.10.10112140107130.8630-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, James Simmons wrote:

> 
> Microsoft patents loading a trusted OS into a trusted CPU. The OS prevents
> untrusted applications from accessing Rights Managed Data.
> 
> http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=/netahtml/search-adv.htm&r=1&f=G&l=50&d=CR99&S1=5,892,900.UREF.&OS=ref/5,892,900&RS=REF/5,892,900

I warned everybody the stuff was coming down the pipes.
This is their method of dealing with content protection and it is going to
pollute the hardware!  The next thing down the pipes will be a requirement
for IPC hardware encryption.

CPU(crypto)<->Memory(crypto)<->Framebuffer(crypto)
ata(clean)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
scsi(crypto)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
CPU(crypto)<->Bridge(crypto)<->Memory(crypto)

Just watch and see!

Andre Hedrick
Linux ATA Development
Linux Disk Certification Project

