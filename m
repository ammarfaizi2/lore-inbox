Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312404AbSCUSEO>; Thu, 21 Mar 2002 13:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312409AbSCUSEF>; Thu, 21 Mar 2002 13:04:05 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18171
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312404AbSCUSDw>; Thu, 21 Mar 2002 13:03:52 -0500
Date: Thu, 21 Mar 2002 10:05:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac4
Message-ID: <20020321180516.GD3201@matchmail.com>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	Adam Kropelin <akropel1@rochester.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu> <006101c1d084$275029b0$02c8a8c0@kroptech.com> <20020321152852.GA2028@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 04:28:52PM +0100, J.A. Magallon wrote:
> 
> On 2002.03.21 Adam Kropelin wrote:
> >Alan Cox wrote:
> >> Linux 2.4.19pre3-ac4
> >
> ><snip>
> >
> >> o The incredible shrinking kernel patch (Andrew Morton)
> >
> >Is there a magic incantation I need in order to see an improvement from this?
> >I'm observing a slight (< 10 KB) increase from -ac3 to -ac4. Same .config, same
> >compiler.
> >
> >I only build 2 modules; everything else is static. Perhaps Andrew's fix is for
> >heavy module users?
> >
> 
> I think it gives about 100k size decrease IFF you have verbose BUG activated.

Wasn't that config option removed (I haven't checked...) with this patch?
