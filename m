Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283703AbRLECng>; Tue, 4 Dec 2001 21:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283705AbRLECn0>; Tue, 4 Dec 2001 21:43:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48625
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283703AbRLECnU>; Tue, 4 Dec 2001 21:43:20 -0500
Date: Tue, 4 Dec 2001 18:43:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: EXT3 - freeze ups during disk writes
Message-ID: <20011204184314.A25292@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112011209190.3893-100000@localhost.localdomain> <E16AX5E-0006pH-00@calista.inka.de> <20011203085258.A4072@billgotchy.de> <3C0C1628.5D73F05A@zip.com.au> <20011204215319.GA8239@billgotchy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204215319.GA8239@billgotchy.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 10:53:19PM +0100, Jan-Hendrik Palic wrote:
> Hi ... 
> 
> On Mon, Dec 03, 2001 at 04:17:44PM -0800, Andrew Morton wrote:
> >> The IBook freezed and I reseted it .. but I had to install the whole
> >> system .. the yaboot wasn't able to find a kernel on the / Partition.
> >> (ext3 too) :)
> >An unrecovered ext3 filesystem is probably unrecognisable to
> >yaboot.  I'm told that yaboot 1.3.5 and later have changes which
> >permit booting from unrecovered ext3 filesystems.
> 
> hmmm ok ... thnx ... :)
> 
> But the IBook freezed with the 2.4.15-ben0 on haevy harddisk/IO .... 
> 
> what could it be?
> 

I would suggest you try another ben0, or use a kernel available from the bk
repositories.

Check out www.penguinppc.org/

mf
