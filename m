Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUDDQBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 12:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUDDQBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 12:01:19 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:31754 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262451AbUDDQBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 12:01:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25: kernel BUG at inode.c:334
Date: Sun, 4 Apr 2004 18:00:49 +0200
User-Agent: KMail/1.6.1
Cc: Matthias Juchem <lists@konfido.de>
References: <200404041752.25721.lists@konfido.de>
In-Reply-To: <200404041752.25721.lists@konfido.de>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404041800.49339@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 April 2004 17:52, Matthias Juchem wrote:

Hi Matthias,

> I am using 2.4.25 and get the following bug approximately once a week:
> Apr  3 08:34:52 xxxxxx kernel: kernel BUG at inode.c:334!
> The server does not hang, but of course it has some serious problems.
> I do not know how the bug is triggered.
> The server is used for some network services which usually do not cause a
> heavy load.
> If you need further information, please ask.
> Please CC me on any replies as I'm not subscribed to LKML.

Please try 2.4.26-rc1. It has a fix for the bug.

ciao, Marc
