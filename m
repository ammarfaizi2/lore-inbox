Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271623AbRHZXjB>; Sun, 26 Aug 2001 19:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271626AbRHZXiu>; Sun, 26 Aug 2001 19:38:50 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:53122 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S271623AbRHZXil>; Sun, 26 Aug 2001 19:38:41 -0400
Message-ID: <3B89857D.2B3B94F1@randomlogic.com>
Date: Sun, 26 Aug 2001 16:25:49 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: [OOPS] Red Hat 7.1 and 7.2 Beta 2 Install
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I consistently get an Oops when attempting to install either of these on
my A7V133/Athlon 1.4GHz. It happens every time the install attempts to
create ext2 or ext3 file systems on the IDE drive. I boot with  nodma
option for both ide0 and ide1.

I've heard of threads relating to this before, but I thought I'd send
this e-mail for clarification. I'm wondering if I have a bad MoBo, as
I've also had problems running fsck on a Ultra 160 SCSI drive that has
RH 6.2 installed on it using the same system.

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
