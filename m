Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRHQGs0>; Fri, 17 Aug 2001 02:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269756AbRHQGsQ>; Fri, 17 Aug 2001 02:48:16 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:19721 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S269735AbRHQGsI>; Fri, 17 Aug 2001 02:48:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: question about tmpfs
Date: Fri, 17 Aug 2001 02:48:20 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010817064809Z269735-760+2777@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked in the documentation for something about tmpfs and looked around for 
some obvious tmpfs source but couldn't find any to figure out how to know 
when/if it's doing what it's supposed to.  when i ls the dir it's mounted to 
i get nothing and this is what df gives me.
Filesystem           1k-blocks    Used    Available Use% Mounted on
tmpfs                   144108        0        144108       0%       /dev/shm

There are some mounting options that i did not use, just let it go to 
defaults, and i've got a fair amount of shared memory programs open and i'm 
just unable to tell if this is working correctly and if not how to fix it.  
If anyone can point me to the right place to look that would be great.  
Hopefully this kernel, 2.4.9, will not cause mozilla to start getting 
retarded after 5 days of uptime.  
