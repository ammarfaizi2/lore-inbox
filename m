Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRLOAgd>; Fri, 14 Dec 2001 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRLOAgN>; Fri, 14 Dec 2001 19:36:13 -0500
Received: from vitelus.com ([64.81.243.207]:61962 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S281024AbRLOAgD>;
	Fri, 14 Dec 2001 19:36:03 -0500
Date: Fri, 14 Dec 2001 16:32:35 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] DRM OS
Message-ID: <20011214163235.A17636@vitelus.com>
In-Reply-To: <Pine.LNX.4.10.10112121959320.8479-100000@www.transvirtual.com> <Pine.LNX.4.10.10112140107130.8630-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112140107130.8630-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 01:15:48AM -0800, Andre Hedrick wrote:
> CPU(crypto)<->Memory(crypto)<->Framebuffer(crypto)
> ata(clean)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> scsi(crypto)<->diskcontroller(crypto)<->Memory(crypto)<->CPU(crypto)
> CPU(crypto)<->Bridge(crypto)<->Memory(crypto)
> 
> Just watch and see!

Why would crypto help at all?
