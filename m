Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRK1UAj>; Wed, 28 Nov 2001 15:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRK1UAa>; Wed, 28 Nov 2001 15:00:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39676
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280537AbRK1UAS>; Wed, 28 Nov 2001 15:00:18 -0500
Date: Wed, 28 Nov 2001 12:00:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] earlier printk output
Message-ID: <20011128120012.B513@mikef-linux.matchmail.com>
Mail-Followup-To: James Simmons <jsimmons@transvirtual.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C044816.D6DCD2D3@mandrakesoft.com> <Pine.LNX.4.10.10111280945060.11130-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10111280945060.11130-100000@www.transvirtual.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 09:45:35AM -0800, James Simmons wrote:
> 
> > > This patch creates console devices specifically for use during early
> > > boot, and registers them so that printk() output may be seen prior
> > > to console_init().
> > 
> > > Included are i386 config options, early VGA text output, and early i386
> > > serial output.
> > 
> > nice.  these patches work on some non-x86 platforms too...
> 
> Where is this patch? Sine I have rewritten the console/tty layer I'm quite
> interested in this.
The patch is available from:

        ftp://ftp.kernel.org/pub/linux/kernel/people/wli/early_printk/
	
As mentioned by the origional message...	
