Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbTCZKiV>; Wed, 26 Mar 2003 05:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCZKiU>; Wed, 26 Mar 2003 05:38:20 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:59299 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id <S261558AbTCZKiT>; Wed, 26 Mar 2003 05:38:19 -0500
Date: Wed, 26 Mar 2003 10:48:56 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Greg KH <greg@kroah.com>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Preferred way to load non-free firmware
Message-ID: <20030326104856.GA31375@axis.demon.co.uk>
References: <Pine.LNX.4.50.0303252007420.6656-100000@marabou.research.att.com> <20030326041146.GD20858@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326041146.GD20858@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:11:46PM -0800, Greg KH wrote:
> > 7) Encode the firmware into a header file, add it to the driver and
> > pretend that the copyright issue doesn't exist (like it's done in the
> > Keyspan USB driver).
> 
> Hey, that's the way I like doing this stuff :)

If you do this the Debian kernel mainainers will mercilessly rip your
non-free driver firmware from the standard Debian kernel.  At least
that is what happened with the Keyspan :-(

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
