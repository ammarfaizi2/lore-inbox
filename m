Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSEFRVD>; Mon, 6 May 2002 13:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314601AbSEFRVC>; Mon, 6 May 2002 13:21:02 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:20728
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314600AbSEFRVB>; Mon, 6 May 2002 13:21:01 -0400
Date: Mon, 6 May 2002 10:20:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ext3 errors with 2.4.18
Message-ID: <20020506172047.GL2392@matchmail.com>
Mail-Followup-To: "Udo A. Steinberg" <reality@delusion.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD6AE7A.FBEB5726@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 06:25:30PM +0200, Udo A. Steinberg wrote:
> 
> Hi,
> 
> With Linux 2.4.18, I'm getting multiple of the following error:
> 
> EXT3-fs error (device ide0(3,2)): ext3_readdir: bad entry in directory #1966094:
> rec_len % 4 != 0 - offset=0, inode=3180611420, rec_len=53134, name_len=138
> 
> Can someone decipher this?

Can you post the surrounding lines from dmesg?  Many times there is another
error that tells much more than the one you just posted...
