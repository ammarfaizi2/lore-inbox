Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290072AbSAQRNE>; Thu, 17 Jan 2002 12:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290074AbSAQRMz>; Thu, 17 Jan 2002 12:12:55 -0500
Received: from the-penguin.otak.com ([216.122.56.136]:15488 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S290072AbSAQRMl>; Thu, 17 Jan 2002 12:12:41 -0500
Date: Thu, 17 Jan 2002 09:12:29 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: DEVFS broken?
Message-ID: <20020117171229.GA1084@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.5.2-dj1 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure how to debug this but it apears that 
in 2.5.3-pre1 and in 2.5.2-dj1 DEVFS is not working.
It started by terminals hanging and not being able to
shutdown.
I went to /dev/ and did a ls, it compleatly hangs that
terminal and I cannot kill ls.
I have the devfsd version from debian 1.3.21 .

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


