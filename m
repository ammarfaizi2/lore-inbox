Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTA0Lho>; Mon, 27 Jan 2003 06:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTA0Lho>; Mon, 27 Jan 2003 06:37:44 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:1041 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267162AbTA0Lho>; Mon, 27 Jan 2003 06:37:44 -0500
Message-ID: <3E351C51.FAF985BC@aitel.hist.no>
Date: Mon, 27 Jan 2003 12:47:29 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Patches have a license
References: <20030127095840.25042.qmail@web13601.mail.yahoo.com> <20030127104705.GC25913@codemonkey.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Mon, Jan 27, 2003 at 01:58:40AM -0800, Balbir Singh wrote:
>  > I would request everyone to post their patches with
>  > a license, failing which it should be assumed that
>  > the license is GPL.
> 
> Surely the license of the diff matches the license of the
> code it is patching ?

Usually in practice, but not necessarily.  Try diff'ing
two files with different licence, then go apply
it at some file with a third licence. :-/

Helge Hafting
