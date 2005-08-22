Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbVHVXCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbVHVXCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHVXC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:02:29 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:24975 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751184AbVHVXC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:02:28 -0400
Date: Mon, 22 Aug 2005 03:49:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Steven French <sfrench@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       samba@samba.org, Urban.Widmark@enlight.net
Subject: Re: New maintainer needed for the Linux smb filesystem
Message-ID: <20050822014956.GI5726@stusta.de>
References: <20050821124657.22f1a095.akpm@osdl.org> <OF200CE886.6A353FBA-ON87257065.0005812F-86257065.0005B594@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF200CE886.6A353FBA-ON87257065.0005812F-86257065.0005B594@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 08:01:57PM -0500, Steven French wrote:
>...
> I don't mind fixing any major smbfs bugs that are found as needed, the code
> is not hard to follow, but I would rather focus on the three current cifs
> priorities:
>...

It sounds as if you would be a great choice as new smbfs maintainer - 
you know both the protocols involved and the Linux kernel.

Noone expects big feature additions to the smbfs code, maintainership 
consists of:
- reviewing patches
- handling bugs (the 16 open bugs in the kernel Bugzilla give a rough
  impression of what problems people face)

cifs might be the future, but until it supports a superset of smbfs
users require smbfs - and a good smbfs makes their life easier.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

