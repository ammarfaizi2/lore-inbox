Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSJ1SaF>; Mon, 28 Oct 2002 13:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSJ1SaF>; Mon, 28 Oct 2002 13:30:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:60624 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261449AbSJ1SaE>; Mon, 28 Oct 2002 13:30:04 -0500
Subject: Re: Linux 2.5.44-ac5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021028181858.GA1245@mars.ravnborg.org>
References: <200210281452.g9SEqwF17910@devserv.devel.redhat.com> 
	<20021028181858.GA1245@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 18:55:09 +0000
Message-Id: <1035831309.1965.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 18:18, Sam Ravnborg wrote:
> On Mon, Oct 28, 2002 at 09:52:58AM -0500, Alan Cox wrote:
> > o	Work around makefile breakages for pcmcia scsi	(me)
> > 	| Will whoever broke vpath please fix it properly
> 
> Being "partner in crime" I would like to give it a try.
> Could you give an advice what is the best approach?

I suspect fixing the vpath in the Makefiles, but that so far has
defeated me

