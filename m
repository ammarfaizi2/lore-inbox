Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281681AbRKQCNq>; Fri, 16 Nov 2001 21:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281682AbRKQCNg>; Fri, 16 Nov 2001 21:13:36 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6139
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281681AbRKQCN0>; Fri, 16 Nov 2001 21:13:26 -0500
Date: Fri, 16 Nov 2001 18:13:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap Usage with Kernel 2.4.14
Message-ID: <20011116181320.E21354@mikef-linux.matchmail.com>
Mail-Followup-To: war <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF5B275.215D6D44@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF5B275.215D6D44@starband.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 07:42:29PM -0500, war wrote:
> Regular usage on my box, launching netscape, opera, pan, xchat, gaim;
> the kernel eventually digs into swap.
> 
> However, the swap is never released?
> 
> Mem:   900596K av,  185896K used,  714700K free,       0K shrd,    4172K
> buff
> Swap: 2048276K av,   63728K used, 1984548K free                   91176K
> cached
> 
> Are there any settings I should have set or be aware of?
> 
> I current use 4GB support, 1GB of ram, 2GB of swap.
> 
> Having 1GB, I thought I had enough memory for basic operations without
> the disk swapping like mad.

run top and change it to show the "swap" field.  Now check to see which
processes are in swap...

Does anyone know another way to get this information?  I didn't find
anything in ps that would help... :(

Mike
