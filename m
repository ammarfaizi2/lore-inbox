Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272416AbTHIQnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272446AbTHIQnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:43:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6923 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S272416AbTHIQnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:43:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jamie Lokier <jamie@shareable.org>, Wes Janzen <superchkn@sbcglobal.net>
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
Date: Sat, 9 Aug 2003 19:43:25 +0300
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
References: <16128.19218.139117.293393@charged.uio.no> <3F34E6D1.7030900@sbcglobal.net> <20030809162710.GC29647@mail.jlokier.co.uk>
In-Reply-To: <20030809162710.GC29647@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308091943.25231.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 19:27, Jamie Lokier wrote:
> Wes Janzen wrote:
> > I seemed to get a skeptical reaction when I originally posted this to
> > the list, however, just google for "mvp3 corrupt dma mode" to confirm.
>
> The VP2/97 also had severe problems with DMA.  I could never run
> standard kernels on mind in the 2.0 days, and distro installs would
> always lock up during installation, although Mandrake 8 seemed
> reliable so something improved.

I had a VIA VPX sometime ago. AFAIR it worked fine...

I suspect PCI conf tweaks etc could work around
this trouble. I'm afraid there won't be much interest
in fixing these oldies. For example, I got rid of that
board (exchanged for Socket A one) -> no way to test fixes :(
--
vda
