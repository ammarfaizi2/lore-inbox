Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRCFIPE>; Tue, 6 Mar 2001 03:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRCFIOy>; Tue, 6 Mar 2001 03:14:54 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:18694 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129394AbRCFIOn>;
	Tue, 6 Mar 2001 03:14:43 -0500
Date: Tue, 6 Mar 2001 09:14:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Riley <oscar@the-rileys.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
Message-ID: <20010306091428.A1034@suse.cz>
In-Reply-To: <E14a26R-0007lp-00@the-village.bc.nu> <3AA406FC.31A212C@the-rileys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA406FC.31A212C@the-rileys.net>; from oscar@the-rileys.net on Mon, Mar 05, 2001 at 04:37:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 04:37:00PM -0500, David Riley wrote:

> Alan Cox wrote:
> > 2.4.2-ac12
> > o       Update VIA IDE driver to 3.21                   (Vojtech Pavlik)
> >         |No UDMA66 on 82c686
> 
> Um... Does that include 686a?  82c686a is supposed to handle UDMA66...
> Or is it a corruption issue again?  UDMA66 seems to work fine on
> mine...  No corruptions yet.

No, just the vt82c686. vt82c686a and vt82c686b are OK.

-- 
Vojtech Pavlik
SuSE Labs
