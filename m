Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbUKRRSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbUKRRSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUKRRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:17:30 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:40622 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262788AbUKRROW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:14:22 -0500
To: hbryan@us.ibm.com
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
In-reply-to: <OF43CCF252.FCCFAB5B-ON88256F50.005CE35E-88256F50.005D8559@us.ibm.com>
	(message from Bryan Henderson on Thu, 18 Nov 2004 09:00:36 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF43CCF252.FCCFAB5B-ON88256F50.005CE35E-88256F50.005D8559@us.ibm.com>
Message-Id: <E1CUprL-00041e-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 18:14:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see how the OOM killer can help you here.  The OOM killer deals 
> with the system being out of virtual memory;

What?  I think you are confusing something.  I'm not an expert, but I
think usually you have lot's of virtual memory (4Gbyte per process),
so killing off processes to get more of it makes no sense. 

Please corrent me if I'm wrong.

Miklos
