Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271357AbTGQLjI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271372AbTGQLjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:39:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18126
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271357AbTGQLjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:39:07 -0400
Subject: Re: Suspend on one machine, resume elsewhere [was Re:
	[Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       root@mauve.demon.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716223935.GF2684@wind.cocodriloo.com>
References: <20030716083758.GA246@elf.ucw.cz>
	 <200307161037.LAA01628@mauve.demon.co.uk> <20030716104026.GC138@elf.ucw.cz>
	 <20030716195129.A9277@informatik.tu-chemnitz.de>
	 <20030716181551.GD138@elf.ucw.cz>
	 <1058383043.6600.53.camel@dhcp22.swansea.linux.org.uk>
	 <20030716223935.GF2684@wind.cocodriloo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058442562.8620.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 12:49:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 23:39, Antonio Vargas wrote:
> > Would it not be a lot easier to tackle that with qemu, and teach qemu to
> > freeze/restore virtual machines ?
> 
> AFAIK, qemu does virtual processes, but not virtual machines. Running init(1)
> from qemu could be fun, anyways ;)

qemu moves on release by release. It can run an entire virtualised linux kernel
nowdays, although its performance still needs some work.

