Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275610AbRIZVZH>; Wed, 26 Sep 2001 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275614AbRIZVY6>; Wed, 26 Sep 2001 17:24:58 -0400
Received: from pixar.pixar.com ([138.72.10.20]:18370 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S275610AbRIZVYq>;
	Wed, 26 Sep 2001 17:24:46 -0400
Date: Wed, 26 Sep 2001 14:25:05 -0700 (PDT)
From: Kiril Vidimce <vkire@pixar.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: max arguments for exec
Message-ID: <Pine.LNX.4.21.0109261417110.24013-100000@nevena>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any way to reconfigure the kernel at runtime to change the
limit for arguments passed during an exec? I guess I am looking for
something similar to systune ncargs under IRIX. I found this thread
in the archives:

http://uwsg.iu.edu/hypermail/linux/kernel/0003.0/0160.html

The only suggestion was to patch and recompile the kernel. I looked
into sysctl and I couldn't find an appropriate argument to tweak.

Thanks for any info,
KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

