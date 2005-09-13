Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVIMThr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVIMThr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIMThq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:37:46 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:33221 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932599AbVIMThq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:37:46 -0400
Date: Tue, 13 Sep 2005 15:37:45 -0400
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
Message-ID: <20050913193745.GH28578@csclub.uwaterloo.ca>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net> <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net> <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca> <Pine.LNX.4.61L.0509131819140.4219@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0509131819140.4219@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 06:21:23PM +0100, Maciej W. Rozycki wrote:
> On Tue, 13 Sep 2005, Lennart Sorensen wrote:
> 
> > Of course mips is extra fun in having two 32bit formats and one 64bit
> > format.
> 
>  The reverse -- two 64-bit formats and one 32-bit one.  And don't forget 
> to multiply by two endiannesses. ;-)

I thought it was 32bit old, 32bit new (for using 32bit pointers on a 64bit
cpu) and 64bit.  At least the names I have seen were 32o, 32n, 64.

Len Sorensen
