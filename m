Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVKRRc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVKRRc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVKRRcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:32:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:54494 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964782AbVKRRcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:32:25 -0500
Message-ID: <437E0F3A.2000906@free.fr>
Date: Fri, 18 Nov 2005 18:28:26 +0100
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: autofs@linux.kernel.org, raven@themaw.net
Subject: Automount ghost option
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want the automount mount points to be visible even if they are not 
mounted.

It seems the "ghost" option implements that. I can find several 
references on the internet which indicates it is available, like:
http://gentoo-wiki.com/HOWTO_Auto_mount_filesystems_(AUTOFS)

Nevertheless, on some recent distributions I have tested on, this option 
is not available.

Can anyone tell me in which version of automount it is present?
Or is it a distribution specific patch?

Thanks!

Olivier


