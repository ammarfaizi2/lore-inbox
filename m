Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283584AbRLDXFR>; Tue, 4 Dec 2001 18:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLDXFI>; Tue, 4 Dec 2001 18:05:08 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:446 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S283578AbRLDXE6>; Tue, 4 Dec 2001 18:04:58 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Adam Keys <akeys@post.cis.smu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: virtual filesystem with data managed in userspace
Date: Tue, 4 Dec 2001 17:05:38 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011204224026.A18753@g> <20011204230053.F23430@vestdata.no>
In-Reply-To: <20011204230053.F23430@vestdata.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011204230452.JPTO24045.rwcrmhc53.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 04, 2001 04:00, Ragnar Kjørstad wrote:
> On Tue, Dec 04, 2001 at 10:40:26PM +0100, Roland Bauerschmidt wrote:
> > Hi,
> >
> > for a science project I'm thinking about writing a virtual filesystem
> > driver that provides access to data that is managed in userspace. I'm
> > quite new to Kernel hacking, so I'd be glad if someone could provide
> > some tips about the design, especially the data exchange between kernel-
> > and userspace.
>
> See http://sourceforge.net/projects/avf/

Maybe we should add this to the lkml FAQ under a heading "Things you think 
are probably crazy but really aren't", or possibly "Fancy microkernel type 
stuff" :)

-- 
akk~
