Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271779AbTGRQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271785AbTGRQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:56:53 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:25745 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S271779AbTGRQ4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:56:49 -0400
Subject: Re: Error compiling, scsi 2.6.0-test1
From: Steven Cole <elenstev@mesatop.com>
To: backblue <backblue@netcabo.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Doug Ledford <dledford@redhat.com>
In-Reply-To: <20030717195952.130827f5.backblue@netcabo.pt>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
	 <ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
	 <20030716232827.2272eccb.backblue@netcabo.pt>
	 <1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>
	 <20030717195952.130827f5.backblue@netcabo.pt>
Content-Type: text/plain
Organization: 
Message-Id: <1058547612.1632.61.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 18 Jul 2003 11:00:12 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 12:59, backblue wrote:
> hello Alan,
> 
> I need this driver, but i dont know anouth of C, to code a new one, that old's on 2.6.0 :(, where to start? i really need it, i have everything scsi on my computer, with this controler, and i dont like the idea, of dont have suport to it!!
> On 17 Jul 2003 12:51:42 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Mer, 2003-07-16 at 23:28, backblue wrote:
> > > I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?
> > 
> > Nobody has coverted this driver to 2.6 yet. If someone does then it will
> > get merged in, if not the initio support will get deleted in time.
> > 

It looks like this came up a year ago:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102526383927111&w=2

You might plead with Doug to finish the conversion.

Steven

