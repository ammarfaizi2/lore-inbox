Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGYKXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGYKXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVGYKXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:23:32 -0400
Received: from nemesis.nephthys.org ([82.67.27.49]:22948 "EHLO
	mx1.nephthys.org") by vger.kernel.org with ESMTP id S261191AbVGYKXb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:23:31 -0400
From: Glennie Vignarajah <glenny@nephthys.org>
Organization: Nephthys
To: linux-kernel@vger.kernel.org
Subject: Re: accessing CD fs from initrd
Date: Mon, 25 Jul 2005 12:23:21 +0200
User-Agent: KMail/1.8.1
References: <BAY17-F4D75DC4B383C374A1BCD3BCCA0@phx.gbl>
In-Reply-To: <BAY17-F4D75DC4B383C374A1BCD3BCCA0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507251223.29013.glenny@nephthys.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Monday 25 July 2005 09:27, zvi Dubitzki("zvi Dubitzki" 
<zvidubitzki@hotmail.com>) disait:

Hello,

> In need access the CD filesystem (iso9660) from within the Linux
> initrd or right after that (make it root fs).
> I need an example for that since allocating enough ramdisk space
> (ramdisk_size=90k in kernel command line)  + loading the cdrom.o
> module at the initrd did not help  mount the CD device
> (/dev/cdrom)  at the initrd
> Also I need know how to pivot between the initrd and the CD
> filesystem

'MkCDrec' makes a bootable CDs. Have look at it. It uses shells 
scripts only. So, it's easy to understand. If you want, I can mail 
you the initrd made by those scripts!

 If you're using Debian, have a look at bootcd-mkinitrd package !

 I suppose any live CDs  based distributions (like knopix) do such 
things too....


 By the way, this is not the correct ML for these questions. Please 
use a list based on your GNU/Linux distribution !

-- 
Glennie
"Personne ne survit au fait d'être estimé au-dessus de sa valeur." 
