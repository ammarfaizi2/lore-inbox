Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRINUOy>; Fri, 14 Sep 2001 16:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270201AbRINUOo>; Fri, 14 Sep 2001 16:14:44 -0400
Received: from mail.missioncriticallinux.com ([208.51.139.18]:14099 "EHLO
	missioncriticallinux.com") by vger.kernel.org with ESMTP
	id <S270178AbRINUOf>; Fri, 14 Sep 2001 16:14:35 -0400
Message-ID: <3BA26542.21DC105A@MissionCriticalLinux.com>
Date: Fri, 14 Sep 2001 13:14:58 -0700
From: Bruce Blinn <blinn@MissionCriticalLinux.com>
Organization: Mission Critical Linux
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.6-bcb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reading Windows CD on Linux 2.4.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I sent the following message to the kernel newbies mailing list, and it
was suggested that I send it to the kernel mailing list.  I am not a
subscriber of this mailing list, so I would appreciate any replies being
sent to me directly.

-----------------------

I have found that after upgrading from 2.2.19 to 2.4.6, I can no longer
read CD-ROMs that were created under Windows.  Since they work fine on
2.2.19, I assume there is some configuration option that has changed,
but I did not see anything that looked suspicious.

I can mount the CD and list the files on it, but when I try to access
one of the files on it, I get an IO error.

When I created the disk on Windows, I selected the option to "Organize
the disc so it can be read in most standard CD-ROM drives...".  On
Linux, I selected the kernel options for ISO 9660 and the Joliet
extensions.

Does anyone have any ideas about what I am doing wrong?

Thanks,
Bruce
-- 
Bruce Blinn                               408-615-9100
Mission Critical Linux, Inc.              blinn@MissionCriticalLinux.com
www.MissionCriticalLinux.com
