Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276781AbRJBXax>; Tue, 2 Oct 2001 19:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276788AbRJBXao>; Tue, 2 Oct 2001 19:30:44 -0400
Received: from www.netlabs.net ([216.116.135.2]:41705 "EHLO www.netlabs.net")
	by vger.kernel.org with ESMTP id <S276781AbRJBXa2>;
	Tue, 2 Oct 2001 19:30:28 -0400
Date: Tue, 2 Oct 2001 19:38:38 -0400
From: Terry Warner <twarner@netlabs.net>
To: linux-kernel@vger.kernel.org
Subject: Ext3 and 2.4.10-ac problem
Message-ID: <20011002193838.A12922@netlabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: BSD/OS 4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using ext3 from cvs and 2.4.10-ac4, (this has happened since 2.4.9-ac13 about)

I get this error when I do a make bzImage.

exec_domain.c:23: `default_exec_domain' undeclared here (not in a function)
make[2]: *** [exec_domain.o] Error 1
make[2]: Leaving directory `/home/keerf/src/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/keerf/src/linux/kernel'
make: *** [_dir_kernel] Error 2

Could I have something wrong in my config? Any ideas would be helpful.

Thank you

Terry


//Terry Warner//
twarner@netlabs.net 
Senior Technical Associate 
Internet Labs 
(732) 264-3111 x169
http://netlabs.net
