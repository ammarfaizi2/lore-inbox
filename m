Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbTCaLct>; Mon, 31 Mar 2003 06:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCaLct>; Mon, 31 Mar 2003 06:32:49 -0500
Received: from [81.2.110.254] ([81.2.110.254]:11256 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261584AbTCaLcs>;
	Mon, 31 Mar 2003 06:32:48 -0500
Subject: Re: hdparm and removable IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: house@uqd.edu.au, Andre Hedrick <andre@linux-ide.org>, davidsen@tmr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303311121.h2VBL63v020452@81-2-122-30.bradfords.org.uk>
References: <200303311121.h2VBL63v020452@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049111033.16120.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 31 Mar 2003 12:43:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-31 at 12:21, John Bradford wrote:
> > > Something that occurs to me - if a machine has non hot-swap capable
> > > IDE hardware, but has suspend to RAM functionality, presumably it is
> > > OK from an electronic viewpoint to swap disks?  What about PCI hot
> > > swap?  Presumably we can remove a non hot-swap IDE controller
> > > completely, and re-install it with different drives connected?
> > 
> > It is but Linux doesn't support it
> 
> Not yet :-)
> 
> Seriously, I thought both were under active development - is this a
> 2.7, or 2.9 timescale thing?

Probably yes

