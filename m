Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSHMMPD>; Tue, 13 Aug 2002 08:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHMMPC>; Tue, 13 Aug 2002 08:15:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3320 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315200AbSHMMPB>; Tue, 13 Aug 2002 08:15:01 -0400
Subject: Re: 2.5.31 hda: lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kees Bakker <kees.bakker@altium.nl>
Cc: Irwan Hadi <irwanhadi@phxby.engr.usu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <15704.44325.696035.477628@koli.tasking.nl>
References: <15703.24219.318219.380751@koli.tasking.nl>
	<20020812153125.GA29884@phxby.com>
	<1029167456.16421.174.camel@irongate.swansea.linux.org.uk> 
	<15704.44325.696035.477628@koli.tasking.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 13:16:24 +0100
Message-Id: <1029240984.21007.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> My solution was to move back to ext2fs and kernel 2.4.18, although for
> >> this I needed to fsck the hard drive a couple times because of the
> >> occured corruption to the filesystem.
> 
> Alan> ext3 is stable on 2.4 systems.
> 
> And on 2.5 systems, right?

Thats tricky to answer until all the other bugs in 2.5 are fixed, since
any one of them could turn out to be ext3. It should work, but 'stable'
isnt a word I'd apply to the development tree at least in part because
there is so much new code that hasnt been beaten on hard

