Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTDNNXM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTDNNXM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:23:12 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:19418 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263009AbTDNNXL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 09:23:11 -0400
Date: Mon, 14 Apr 2003 07:34:54 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Ken Brownfield <brownfld@irridia.com>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Oops: ptrace fix buggy
In-Reply-To: <200304121154.32997.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0304140713510.22450-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003, Marc-Christian Petersen wrote:

> On Saturday 12 April 2003 09:13, Ken Brownfield wrote:
> 
> Hi Ken,
> 
> > I'm reproducing this as well when using gdb.  Two oopses attached.
> > This is with the ptrace patch applied to 2.4.20 (SMP/i386/P3).
> Does the attached patch fixes the issue?

Hi,
This patch has also been added to the update patch available at
http://www.hardrock.org/kernel/current-updates/linux-2.4.20-updates.patch

This patch includes the ptrace patch, tg3 patch, and ext3 patches.  It also
changes the EXTRAVERSION to -uv2.

Regards
James Bourne

> 
> ciao, Marc

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  


