Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbRGPXds>; Mon, 16 Jul 2001 19:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbRGPXdh>; Mon, 16 Jul 2001 19:33:37 -0400
Received: from adsl-63-196-157-142.dsl.lsan03.pacbell.net ([63.196.157.142]:6924
	"HELO adsl-63-196-157-142.dsl.lsan03.pacbell.net") by vger.kernel.org
	with SMTP id <S267736AbRGPXdZ>; Mon, 16 Jul 2001 19:33:25 -0400
Date: Mon, 16 Jul 2001 16:30:04 -0700
From: "Tim R. Young" <try@lyang.net>
To: Dave Jones <davej@suse.de>
Cc: Ignacio Vazquez-Abrams <ignacio@openservices.net>,
        "Tim R. Young" <try@lyang.net>, linux-kernel@vger.kernel.org
Subject: Re: cpu id?
Message-ID: <20010716163004.A1103@box.lyang.net>
Reply-To: try@lyang.net
In-Reply-To: <Pine.LNX.4.33.0107161741470.14084-100000@terbidium.openservices.net> <Pine.LNX.4.30.0107162349050.21512-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0107162349050.21512-100000@Appserv.suse.de>; from davej@suse.de on Mon, Jul 16, 2001 at 11:51:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thanks for the tool.
Do I need kernel support to read out intel processor serial number?
And how it is reported by x86info?

- T.

Is it possible to use it read out
On Mon, Jul 16, 2001 at 11:51:01PM +0200, Dave Jones wrote:
> On Mon, 16 Jul 2001, Ignacio Vazquez-Abrams wrote:
> 
> > > I need a user space tool to read out cpu id.
> > > Or documnent that specifies the interface in kernel.
> > > Thanks in advance.
> > cat /proc/cpuinfo
> 
> ftp://ftp.suse.com/pub/people/davej/x86info/
> 
> regards
> 
> Dave
> 
> -- 
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
> 
> 
