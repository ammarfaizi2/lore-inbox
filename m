Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSHUNQW>; Wed, 21 Aug 2002 09:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSHUNQW>; Wed, 21 Aug 2002 09:16:22 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:3838 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318270AbSHUNQW>; Wed, 21 Aug 2002 09:16:22 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>, alan@lxorguk.ukuu.org,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020821121747.A3801@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk>
	<Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
	<20020818131515.A15547@ucw.cz>
	<1029672964.15858.17.camel@irongate.swansea.linux.org.uk> 
	<20020821121747.A3801@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 14:20:07 +0100
Message-Id: <1029936007.26411.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 11:17, Vojtech Pavlik wrote:
> I have completely rewritten (and very well tested) versions of the amd
> and piix pci ide drivers.

I have completely non-rewritten piix drivers that work extremely well
are now easy to read, commented and have done for a very long time. Why
do I want rewritten ones ?
 
> I'm now looking through 2.4.20-pre2-ac5 and your version of via82cxxx.c,
> and all looks quite good to me, except for some of the indentation
> changes which seem to make the code fit into 78 columns at the loss of
> readability. Was the file run through indent?

Andre may have indented it a bit. I've probably caused a bit of noise in
checking all the static's etc

