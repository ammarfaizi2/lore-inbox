Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVLISTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVLISTy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVLISTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 13:19:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:16076 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964843AbVLISTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 13:19:54 -0500
Message-Id: <20051209180414.872465000@localhost>
Date: Fri, 09 Dec 2005 19:04:14 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Re: Cell updates for powerpc.git
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 08 Dezember 2005 07:18, Paul Mackerras wrote:
>
> I have put patches 1..7 and 9 into the powerpc.git tree.  Please
> address Milton's comments on patches 3, 5, 8 and 10.

Milton's comment for patch 5 was about the patch comment, I don't
think I can address that any more.

Here come updated version for patches 8 and 10, a fix for patch 3
and a number of other patches that have come up in the last week.
All patches apply on top of today's powerpc.git tree.

More patches will be coming to address the concerns of Al Viro
about spufs.

Thanks,

	Arnd <><

