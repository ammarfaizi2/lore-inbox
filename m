Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936698AbWLCLva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936698AbWLCLva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936696AbWLCLva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:51:30 -0500
Received: from [83.101.158.156] ([83.101.158.156]:21120 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S936693AbWLCLv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:51:29 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent inode numbers (via idr)
Date: Sun, 3 Dec 2006 14:52:25 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <457040C4.1000002@redhat.com> <45723CDB.1060304@redhat.com> <20061202125851.GA30187@cynthia.pants.nu>
In-Reply-To: <20061202125851.GA30187@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031452.25361.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Boyer wrote:
> To be honest, I think it looks bad for someone associated with redhat
> to be suggesting that life should be made more difficult for those
> who write proprietary software on Linux. The support from commercial
> software is a major reason for the success of the RHEL product line.

The real reason for the success of the RHEL product line is that its been GPL 
from the beginning.  And commercial software saw it fit to leverage this 
GPL-pool, which is OK, but to then come around and say that "The support 
from commercial software is a major reason for the success of the RHEL 
product line" is trying to portray the situation up-side-down.

This does not mean that we shouldn't allow non-GPL linkage, on the contrary, 
I am even calling for a stable API for the benefit of everyone, but it's 
probably the closed-source market's arrogant behavior that forces 
GPL-developers to respond in kind.  Which is rather sad, if you think about 
it.


Thanks!

--
Al

