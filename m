Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVHOSh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVHOSh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVHOSh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:37:58 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:9652 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964870AbVHOSh5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:37:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DoxlFLyDA9o3Eegse8FOH3I+WHFFV/p3QNoKyEjvjNxYM8VEpARm0nz0D1NAAtPZuW61lOpdfwY+DxmQgGjzsxfOEccqRjeuZFnLPib3DVACCLvN8nmpVGNdCHHzjgPAAq12x3plSEM4fh5OSmbfaExHVyKPfkZT8rfJw5J42yE=
Message-ID: <29495f1d05081511374d1f2fc7@mail.gmail.com>
Date: Mon, 15 Aug 2005 11:37:54 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [USB-Storage : i386] Oops with an adaptor for laptop hard disk.
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20050815182947.GA6286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050815102925.GA843@localhost.localdomain>
	 <20050815110836.GA16201@mipter.zuzino.mipt.ru>
	 <20050815112122.GB6451@localhost.localdomain>
	 <20050815162437.GA10114@kroah.com>
	 <20050815182947.GA6286@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> Le Monday 15 August 2005 a 09:08, Greg KH ecrivait:
> > On Mon, Aug 15, 2005 at 01:21:22PM +0200, Stephane Wirtel wrote:
> > > Le Monday 15 August 2005 a 15:08, Alexey Dobriyan ecrivait:
> > > > On Mon, Aug 15, 2005 at 12:29:25PM +0200, Stephane Wirtel wrote:
> > > > > With a laptop hard disk adaptop to usb, I do a modprobe with the
> > > > > usb-storage module. If I disconnect my hard disk, I get an oops.
> > > >
> > > > > nvidia 3711688 14 - Live 0xe10f1000
> > > >
> > > > > EIP:    0060:[<c019710b>]    Tainted: P      VLI
> > > >
> > > > Is it reproducable without nvidia module loaded?
> > > Yes :(
> >
> > Can you do so with 2.6.13-rc6 and without the nvidia module?  If so,
> > please let us know.
> I try to patch a 2.6.12.4 with the 2.6.13-rc6 prepatch, but I get some
> Hunks

That's because 2.6.13-rc6 is based off of 2.6.12.

Thanks,
Nish
