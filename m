Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317973AbSGWGu7>; Tue, 23 Jul 2002 02:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317974AbSGWGu6>; Tue, 23 Jul 2002 02:50:58 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:65504 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317973AbSGWGu5>; Tue, 23 Jul 2002 02:50:57 -0400
Date: Tue, 23 Jul 2002 00:54:02 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Lim <Daniel.Lim@dpws.nsw.gov.au>
cc: thunder@ngforever.de, <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd problem
In-Reply-To: <sd3d8929.019@out-gwia.dpws.nsw.gov.au>
Message-ID: <Pine.LNX.4.44.0207230052550.3241-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> The /proc/mounts does NOT show any loopback devices. I have however,
> umounted 3 FS but it still failed with same messages??

It was about umounting loop filesystems...

What do you have in /dev/loop (devfs), or what /dev/loopx devices (no 
devfs, ls /dev/loop*) do you have?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

