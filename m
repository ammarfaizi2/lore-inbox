Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTHZQJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTHZQJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:09:16 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:62082
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262752AbTHZQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:09:09 -0400
Date: Tue, 26 Aug 2003 12:08:03 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where'd my second proc go?
In-Reply-To: <20030826154343.GU16183@rdlg.net>
Message-ID: <Pine.LNX.4.53.0308261207180.6876@montezuma.fsmlabs.com>
References: <20030826151225.GT16183@rdlg.net> <Pine.LNX.4.53.0308261124200.6876@montezuma.fsmlabs.com>
 <20030826154343.GU16183@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Robert L. Harris wrote:

> Thus spake Zwane Mwaikambo (zwane@linuxpower.ca):
> 
> > On Tue, 26 Aug 2003, Robert L. Harris wrote:
> > 
> > > 
> > > 
> > > Dual-P3-850.  Bios reports both procs.  2.4.21-ac3 reported both procs.
> > > 2.4.22-rc2-ac1 only shows one.  The lilo used to have a "maxcpus=1"
> > > append but I removed that and I tried changing it to 4 even.  cat
> > > /proc/cpu only shows 1 still.
> > 
> > dmesg?

It looks strange, can you boot with 'debug' kernel parameter and send the 
entire /var/log/dmesg

Thanks

