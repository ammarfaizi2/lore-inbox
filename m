Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135237AbRDLRUg>; Thu, 12 Apr 2001 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135235AbRDLRU0>; Thu, 12 Apr 2001 13:20:26 -0400
Received: from penguin.roanoke.edu ([199.111.154.8]:39687 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S135236AbRDLRUL>; Thu, 12 Apr 2001 13:20:11 -0400
Message-ID: <3AD5E682.97A6A7C4@linuxjedi.org>
Date: Thu, 12 Apr 2001 13:31:46 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: viro@math.psu.edu
CC: linux-kernel@vger.kernel.org
Subject: union mounting?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

	I'm working on an embedded distro, and it would be nice if I could just
mount 'packages' over the top of one another; each 'package' is a cramfs
filesystem.  I'm currently using a bunch of symlink stuff, but it's not
real pretty.  If you've got union mounting patches for testing, I'd be
interested. ;-)

regards,
	David
-- 
David L. Parsley
Network Administrator
Roanoke College
