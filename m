Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTENL0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTENL0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:26:16 -0400
Received: from [205.167.22.167] ([205.167.22.167]:8198 "EHLO
	mks-smtp-1.mksinst.com") by vger.kernel.org with ESMTP
	id S261820AbTENL0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:26:15 -0400
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Nicolae_Popovici@mksinst.com
Subject: 2.4.20 freeze problem.
Date: Wed, 14 May 2003 13:29:03 +0200
Message-ID: <OF62F619BA.8F047904-ONC1256D26.003F15BF-C1256D26.003F15D8@mksinternal.com>
X-MIMETrack: Serialize by Router on MKS-ANDOVER-2/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 07:35:53 AM,
	Itemize by SMTP Server on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 07:39:30 AM,
	Serialize by Router on MKS-SMTP-1/NA/MKS(Release 5.0.11  |July 24, 2002) at
 05/14/2003 07:39:48 AM,
	Serialize complete at 05/14/2003 07:39:48 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo guys,

  I tried to post to the list a couple of times but without any success.
So here are the facts.
I have a small user program and the latest 2.4.20 stable kernel.
It is running on a board from IEI ( Wafer-5823 ) with a Cyrix 300 CPU.
 What happens is that after 2 hours of running this user program the
computer
freezes. I have the linux crash dump compiled inside the kernel and
activated
along with the magic sysrq key. Nothing works. I get only some messages
inside
the /var/log/messages but none of them are related to the crash ( modprobe
says it
can not load some module ).

Any ideeas of how to move forward with this will be greatly appreciated.
Cheers,
Nicu


