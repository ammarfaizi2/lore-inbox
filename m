Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265432AbTF1WAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbTF1WAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:00:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265432AbTF1WAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:00:52 -0400
Date: Sat, 28 Jun 2003 23:15:07 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628221507.GI841@gallifrey>
References: <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk> <20030628191847.GB8158@work.bitmover.com> <20030628193857.GH841@gallifrey> <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:12:22 up 1 day,  3:29,  1 user,  load average: 0.03, 0.10, 0.14
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Sad, 2003-06-28 at 20:38, Dr. David Alan Gilbert wrote:
> > Tapes are a pain; but at the type of 40GB range is it worth considering
> > a pile of external USB/Firewire hard drives?
> 
> I'm testing the USB2 disk idea at the moment. Big problem is performance
> - 5Mbytes/second isnt the best backup rate in the world.

Hmm - why should it suck so badly? Shouldn't USB 2 (yes I mean the
480Mbps) manage 40MByte/s+ ?

Disc struck me as so nice in the sense that its a file system and you
don't need extra software, and that the recovery time is near instant.

(Incidentally - putting it in a RAID1 with a main  disc would seem
an interesting option and just letting RAID take a copy of the file
system)

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
