Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVE3M3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVE3M3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVE3M3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:29:01 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:59314 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261511AbVE3M26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:28:58 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 30 May 2005 14:26:43 +0200
To: toon@hout.vanvergehaald.nl, ltd@cisco.com
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429B0683.nail5764GYTVC@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
In-Reply-To: <20050530093420.GB15347@hout.vanvergehaald.nl>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toon van der Pas <toon@hout.vanvergehaald.nl> wrote:

> > look up the man page for udev(8), pay particular attention to the part
> > that can tie devname into device serial number.
> > take note of the example shown under 'serial'.
>
> These were my thoughts too.
> But I just checked the entries in my sysfs tree for my CDRW drive,
> and there is no serial number available...

BTW: an implementation that uses something like Solaris does with
/etc/path_to_inst and puts USB serial numbers into the path_to_inst 
kernel instance database could come very close to the desired result 
and would give stable SCSI addresses too.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
