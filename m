Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271947AbRH2LsA>; Wed, 29 Aug 2001 07:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271948AbRH2Lrv>; Wed, 29 Aug 2001 07:47:51 -0400
Received: from thunderchild.ikk.sztaki.hu ([193.225.87.24]:54533 "HELO
	thunderchild.ikk.sztaki.hu") by vger.kernel.org with SMTP
	id <S271947AbRH2Lrk>; Wed, 29 Aug 2001 07:47:40 -0400
Date: Wed, 29 Aug 2001 13:47:57 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
To: linux-kernel@vger.kernel.org
Subject: Re: vm problems
Message-ID: <20010829134757.A6202@thunderchild.ikk.sztaki.hu>
In-Reply-To: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010829131419.Z6202@thunderchild.ikk.sztaki.hu>; from gorgo@thunderchild.debian.net on Wed, Aug 29, 2001 at 01:14:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 01:14:19PM +0200, Gergely Madarasz wrote:
> Hello,
> 
> I get hundreds of this error message:
> 
> __alloc_pages: 0-order allocation failed.
> 
> The machine is an IBM x250 with 4G ram, the kernel is vanilla 2.4.9 and
> 2.4.9-ac3, no swap, running bonnie++. When the memory fills up with cache,
> I start receiving the error message. 

actually I thought I was running 2.4.9-ac3, but no, and I see the message
is commented out in 2.4.9-ac3. Does this mean that it doesn't mean
anything serious? Some of my processes were stuck in uninterruptible
sleep, I couldn't even shutdown correctly, so there are some problems.

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
                  HuLUG: http://mlf.linux.rulez.org/
