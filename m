Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262221AbSJJXCI>; Thu, 10 Oct 2002 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262223AbSJJXCH>; Thu, 10 Oct 2002 19:02:07 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:40967 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262221AbSJJXCG>; Thu, 10 Oct 2002 19:02:06 -0400
Date: Thu, 10 Oct 2002 19:07:47 -0400
From: Ben Collins <bcollins@debian.org>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ieee1394 hotplug SCSI interaction 2.4.20-pre10
Message-ID: <20021010230747.GC26771@phunnypharm.org>
References: <20021010223700.GA26348@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010223700.GA26348@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I posted my earlier effort to the linux1394-devel list:
>     http://sourceforge.net/mailarchive/forum.php?thread_id=949390&forum_id=5389
> it was decided that the change to the SCSI subsystem needed to
> expose scsi_add_single_device() and scsi_remove_single_device()
> was not desirable.  I'll leave the decision on that to others.

Never said it wasn't desirable per se, just that if Marcelo doesn't
accept that patch, then we can't make use of it. If you feel so strongly
about it, then send that portion of the patch to Marcelo for 2.4.20 or
2.4.21.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
