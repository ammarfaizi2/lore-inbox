Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUITNWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUITNWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUITNWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:22:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:7116 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266512AbUITNVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:21:54 -0400
Date: Mon, 20 Sep 2004 15:21:51 +0200
From: Olaf Hering <olh@suse.de>
To: Helge Hafting <helge.hafting@hist.no>
Cc: DervishD <lkml@dervishd.net>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920132151.GA30175@suse.de>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD> <414EDA10.7050304@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <414EDA10.7050304@hist.no>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 20, Helge Hafting wrote:

> Using a mtab that is a link to /proc/mounts fails with quota too.
> Quta tools read /etc/mtab looking for "usrquota" and or "grpquota"
> mount options.  These appear in a normal /etc/mtab but not in /proc/mounts,

I have never played with quota. But: does the kernel or a userland tool
if quota is active for a mount point? smells like a kernel bug.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
