Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbTDNNpE (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTDNNpE (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:45:04 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:29658 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263301AbTDNNpC convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 09:45:02 -0400
Date: Mon, 14 Apr 2003 07:56:45 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Ken Brownfield <brownfld@irridia.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
In-Reply-To: <20030414134603.GB10347@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0304140748040.22450-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Jörn Engel wrote:

> On Mon, 14 April 2003 07:34:54 -0600, James Bourne wrote:
> > 
> > This patch has also been added to the update patch available at
> > http://www.hardrock.org/kernel/current-updates/linux-2.4.20-updates.patch
> > 
> > This patch includes the ptrace patch, tg3 patch, and ext3 patches.  It also
> > changes the EXTRAVERSION to -uv2.
> 
> Privately, I have introduced a variable FIXLEVEL for this. The
> resulting kernel version is 2.4.20.2 instead of 2.4.20-uv2, which imo
> is more suiting for a fixed stable kernel.
> 
> Are you interested in this patch?

Hi,
Sure, if you have the patch already please send it along.  I think this was
suggested once before as well.

Thanks and regards
James Bourne


> 
> Jörn
> 
> 

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

