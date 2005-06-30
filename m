Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVF3TQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVF3TQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 15:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbVF3TQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 15:16:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:39138 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262964AbVF3TQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:16:52 -0400
Message-ID: <42C444AA.2070508@free.fr>
Date: Thu, 30 Jun 2005 21:14:50 +0200
From: Olivier Croquette <ocroquette@free.fr>
Reply-To: ocroquette@free.fr
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: setitimer expire too early (Kernel 2.4)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am refering to this bug:

http://bugzilla.kernel.org/show_bug.cgi?id=4569

A thread led to a patch from Paulo:

http://kerneltrap.org/mailarchive/1/message/59454/flat

This patch has been included in the kernel 2.6.12.

1. How can I easily check if the patch is planned for include in the 2.4?

2. I downloaded the full 2.4.31 source code. The patch appears not to be 
included. Where/Who should I signal that?

