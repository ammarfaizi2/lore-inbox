Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRG1Poi>; Sat, 28 Jul 2001 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbRG1Po1>; Sat, 28 Jul 2001 11:44:27 -0400
Received: from weta.f00f.org ([203.167.249.89]:7302 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266797AbRG1PoS>;
	Sat, 28 Jul 2001 11:44:18 -0400
Date: Sun, 29 Jul 2001 03:44:52 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with 2.4.7 and VIA IDE
Message-ID: <20010729034452.A2685@weta.f00f.org>
In-Reply-To: <lxvgkddrsh.fsf@pixie.isr.ist.utl.pt> <lxn15pdr5p.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxn15pdr5p.fsf@pixie.isr.ist.utl.pt>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 04:12:02PM +0100, Rodrigo Ventura wrote:

            This is sort of a continuation of my last msg. I tried a rpm
    -Va on one xterm and a tar cf /dev/null / on another, and I got
    another dma error:
    
    hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
    hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

bad IDE cable?

            I also have errors from the ethernet devices, e.g.
    
    eth0: Transmit error, Tx status register 82.
    Probably a duplex mismatch.  See Documentation/networking/vortex.txt
    ^^^^^^^^^^^^^^^^^^^^^^^^^^
look   |



  --cw

