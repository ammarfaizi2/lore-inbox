Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283756AbRLEEyi>; Tue, 4 Dec 2001 23:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283758AbRLEEy3>; Tue, 4 Dec 2001 23:54:29 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55284
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283756AbRLEEyW>; Tue, 4 Dec 2001 23:54:22 -0500
Date: Tue, 4 Dec 2001 20:54:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-aacraid-devel@dell.com
Subject: Re: Aacraid driver 0.9.9ac
Message-ID: <20011204205400.B24847@mikef-linux.matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-aacraid-devel@dell.com
In-Reply-To: <20011204013052.G5320@mikef-linux.matchmail.com> <E16BC9e-0001Tr-00@the-village.bc.nu> <20011204111454.H5320@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011204111454.H5320@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 11:14:54AM -0800, Mike Fedyk wrote:
> On Tue, Dec 04, 2001 at 09:46:22AM +0000, Alan Cox wrote:
> > > 00:02.1 Memory controller: Dell Computer Corporation PowerEdge Expandable
> > > RAID Controller 2/Si (rev 01)
> > 
> > i960 or ARM based ?
> >
> 
> I don't know.  I'm attaching the dmesg output from 2.4.14+ext3+old-aacraid,
> maybe that'll help.

I've been able to find out that it is i960 based.

> > > It hung right after printing "Red Hat raid driver"
> > > Interrupts seem to be off.  no keyboard response to caps lock or sysrq.
> > > I can supply .config if desired...
> > 
> > Please. 
> > 
>

Also not working with aacraid-0.99ac2.diff

Mike
