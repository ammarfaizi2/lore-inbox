Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTATMoV>; Mon, 20 Jan 2003 07:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTATMoU>; Mon, 20 Jan 2003 07:44:20 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:13704
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S265700AbTATMoT>; Mon, 20 Jan 2003 07:44:19 -0500
Message-ID: <3E2BF107.AB48694E@mscsoftware.com>
Date: Mon, 20 Jan 2003 13:52:24 +0100
From: Martin Knoblauch <"martin.knoblauch "@mscsoftware.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-ac1-mkn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: riel@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: Disabling file system caching
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.17.0.2; VDF: 6.17.0.17
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 01/20/2003 01:48:28 PM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 01/20/2003 01:48:36 PM,
	Serialize complete at 01/20/2003 01:48:36 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Disabling file system caching
> 
> From: Rik van Riel (riel@conectiva.com.br)
> Date: Sun Jan 19 2003 - 20:05:00 EST
> 
> On Sun, 19 Jan 2003, Jean-Eric Cuendet wrote:
> 
> > Is it possible to disable file caching for a given partition or mount?
> 
> No, if you do that mmap(), read(), write() etc. would be impossible.
> 
> > Or at least to limit it at a certain quantity of memory?
> 
> Not yet. I'm thinking of implementing something like this
> for the next version of -rmap (reclaim only from the cache
> if the cache occupies more than a certain fraction of ram).
> 

 Yes please !!!
   Yes please !!!
     Yes please !!!

 :-)

 Having a maximum [and maybe minimum] knob for controlling the cache
would be an extremely useful feature in some situations.

Martin
