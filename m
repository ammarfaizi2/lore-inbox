Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHDEyq>; Sat, 4 Aug 2001 00:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269797AbRHDEyg>; Sat, 4 Aug 2001 00:54:36 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:19979 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269796AbRHDEyc>; Sat, 4 Aug 2001 00:54:32 -0400
Date: Sat, 4 Aug 2001 00:54:38 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: UMSDOS symlink fix
In-Reply-To: <MPBBLFNMFLHJNJCJDPMCGEOLDMAA.Delbert@Matlock.com>
Message-ID: <Pine.LNX.4.33.0108040053560.27750-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Delbert Matlock wrote:

> Enclosed is a one line fix for symlinks under the UMSDOS filesystem.  Under
> stock 2.4.7 (and 2.4.7-ac4), if you create a symlink the last letter of the
> original file will be left off the link.  This will fix it.
>
> Now, if I can just get the blasted thing to mount as root.
>
> -- Delbert Matlock
> -- Delbert@Matlock.com
> -- http://delbert.matlock.com/

I'm going to take this opportunity to slip in a small question.

Which is faster, UMSDOS or VFAT?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

