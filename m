Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRKXSmU>; Sat, 24 Nov 2001 13:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKXSmL>; Sat, 24 Nov 2001 13:42:11 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:24757 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279113AbRKXSl4>; Sat, 24 Nov 2001 13:41:56 -0500
Message-ID: <3BFFE9EE.F3402F0A@mandrakesoft.com>
Date: Sat, 24 Nov 2001 13:41:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: ethtool 1.4 released
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ethtool has been made current with kernel 2.4.15/2.5.0.

Only the natsemi driver in the kernel fully supports all capabilities at
this time, but patches are available in gkernel cvs to implement ethtool
support in many more drivers.

Kudos to Tim Hockin @ Sun for most of the implementation work, both in
natsemi and in userspace ethtool.

ChangeLog and download at http://sf.net/projects/gkernel/

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

