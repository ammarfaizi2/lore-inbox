Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317524AbSFKTuA>; Tue, 11 Jun 2002 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSFKTt7>; Tue, 11 Jun 2002 15:49:59 -0400
Received: from [24.71.173.70] ([24.71.173.70]:60304 "EHLO
	valhalla.homelinux.org") by vger.kernel.org with ESMTP
	id <S317524AbSFKTt7>; Tue, 11 Jun 2002 15:49:59 -0400
Date: Tue, 11 Jun 2002 13:47:55 -0600 (CST)
From: "Jason C. Pion" <jpion@valhalla.homelinux.org>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Nick Evgeniev <nick@octet.spb.ru>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <20020611193456.GC9431@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0206111345160.2838-100000@valhalla.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Tomas Szepe wrote:

> > It sounds to me like you've got some flakey hardware.  Don't try to save 
> > the rest of us.  I've been using the Promise drivers with my Ultra 133TX2 
> > for quite a while now and haven't had _ANY_ problems with it.
> 
> Yup, with the exception of the "have to boot with ide2=ata66 to get udma
> 3/4/5 to work" bug, it seems to work perfectly.

Actually, mine doesn't require any boot params for ide.  The attached 
disks are both detected and setup as UDMA(133) right from the get go.  
Works quite well.

Later,
	Jason

