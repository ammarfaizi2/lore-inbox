Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143373AbREKTjA>; Fri, 11 May 2001 15:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143372AbREKTiq>; Fri, 11 May 2001 15:38:46 -0400
Received: from [63.95.87.168] ([63.95.87.168]:15121 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S143371AbREKTiU>;
	Fri, 11 May 2001 15:38:20 -0400
Date: Fri, 11 May 2001 15:38:18 -0400
From: Gregory Maxwell <greg@linuxpower.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010511153818.B19678@xi.linuxpower.cx>
In-Reply-To: <9dgvvn$n3h$1@forge.intermeta.de> <E14yFOk-0001GQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <E14yFOk-0001GQ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 05:04:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 05:04:10PM +0100, Alan Cox wrote:
> > I think with the growing acceptance of ReiserFS in the Linux
> > community, it is tiresome to have to apply a patch again and again
> > just to get working NFS. 2.2 NFS horrors all over again.
> 
> The zero copy patches were basically self contained and tested for 6 months.
> The reiserfs NFS hacks are ugly as hell and dont belong in the base kernel.
> There is a difference.

Does NFS server support for one of the included FSes not belong in the
kernel?  or is it that a better way is possible and this ugly one should not
be included?  If the latter, has anyone told Hans how to do it 'right' so he
can assign someone to the task?
