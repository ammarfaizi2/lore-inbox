Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbUAMQl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUAMQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:41:57 -0500
Received: from p508B5C01.dip.t-dialin.net ([80.139.92.1]:52873 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264375AbUAMQlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:41:42 -0500
Date: Tue, 13 Jan 2004 17:39:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113163934.GB31459@linux-mips.org>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org> <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:07:54PM +0100, Maciej W. Rozycki wrote:

> 
> > > it seems the following is required in Linus' tree to get correct depends 
> > > for DECSTATION:
> > 
> > Thanks,  applied.
> 
>  The dependency was intentional: stable for 32-bit, experimental for
> 64-bit.  I'm reverting the change immediately.  Please always contact me
> before applying non-obvious changes for the DECstation.

Well, this one seemed to be obvious but sometimes things are not what
they seem to be ...

  Ralf
