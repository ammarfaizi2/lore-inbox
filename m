Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVLWDaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVLWDaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVLWDaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:30:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23561 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030393AbVLWDaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:30:09 -0500
Date: Fri, 23 Dec 2005 04:30:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: Chris Wedgwood <cw@f00f.org>, jmerkey@wolfmountaingroup.com,
       rostedt@goodmis.org, mrmacman_g4@mac.com, legal@lists.gnumonks.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       garbageout@sbcglobal.net
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20051223033007.GJ27525@stusta.de>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <43AB32C1.1080101@wolfmountaingroup.com> <20051223025638.GA31381@taniwha.stupidest.org> <20051223041522.ac36635d.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051223041522.ac36635d.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 04:15:22AM +0100, Diego Calleja wrote:
> El Thu, 22 Dec 2005 18:56:38 -0800,
> Chris Wedgwood <cw@f00f.org> escribió:
> 
> > That's entirely debatable and I would recommend the original poster
> > seek legal advice on this as there are many people who will claim
> > loading GPLd modules is paramount to linking and therefore this is a
> > violation.
> 
> So, a GPL application running on top of a BSD-licensed kernel
> (or library) is illegal? I doubt it...

application != kernel module

And your example would anyways not be a problem since GPL + BSD = GPL
(assuming the 3 clause BSD licence).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

