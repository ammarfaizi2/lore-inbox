Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131461AbRC3OTn>; Fri, 30 Mar 2001 09:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbRC3OTd>; Fri, 30 Mar 2001 09:19:33 -0500
Received: from jalon.able.es ([212.97.163.2]:61923 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131461AbRC3OTZ>;
	Fri, 30 Mar 2001 09:19:25 -0500
Date: Fri, 30 Mar 2001 16:18:37 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tmpfs in 2.4.3 and AC
Message-ID: <20010330161837.A1052@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tmpfs (or shmfs or whatever name you like) is still different in official
series (2.4.3) and in ac series. Its a kick in the ass for multiboot,
as offcial 2.4.3 does not recognise 'tmpfs' in fstab:

shmfs  /dev/shm        tmpfs   ...

Any reason, or is because it has been forgotten ?

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3 #2 SMP Fri Mar 30 15:42:05 CEST 2001 i686

