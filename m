Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbTCaLK7>; Mon, 31 Mar 2003 06:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCaLK7>; Mon, 31 Mar 2003 06:10:59 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9988 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261598AbTCaLK6>; Mon, 31 Mar 2003 06:10:58 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303311121.h2VBL63v020452@81-2-122-30.bradfords.org.uk>
Subject: Re: hdparm and removable IDE?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 31 Mar 2003 12:21:06 +0100 (BST)
Cc: house@uqd.edu.au, andre@linux-ide.org, davidsen@tmr.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1049108898.15055.2.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Mar 31, 2003 12:08:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Something that occurs to me - if a machine has non hot-swap capable
> > IDE hardware, but has suspend to RAM functionality, presumably it is
> > OK from an electronic viewpoint to swap disks?  What about PCI hot
> > swap?  Presumably we can remove a non hot-swap IDE controller
> > completely, and re-install it with different drives connected?
> 
> It is but Linux doesn't support it

Not yet :-)

Seriously, I thought both were under active development - is this a
2.7, or 2.9 timescale thing?

John.
